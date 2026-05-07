// Initialize localStorage
if (!localStorage.getItem("quest_completed")) {
  localStorage.setItem("quest_completed", JSON.stringify([]));
}

// Open modal
function openModal(contentHTML) {
  const modal = document.getElementById("questModalQuest");
  const body = document.getElementById("modalBodyQuest");

  if (!modal || !body) {
    console.error("Modal elements not found in DOM");
    return;
  }

  body.innerHTML = contentHTML;
  modal.style.display = "block";
}

// Close modal
function closeModal() {
  const modal = document.getElementById("questModalQuest");
  if (modal) modal.style.display = "none";
}

// Load quests filtered by location + hide completed
function loadQuests() {
  const locationId = sessionStorage.getItem("location_id");

  if (!locationId) {
    alert("No location set!");
    return;
  }

  const completed = JSON.parse(localStorage.getItem("quest_completed")) || [];

  fetch(`/quests/${locationId}`)
    .then((res) => res.json())
    .then((data) => {
      let html = "<h3>Select a Quest</h3>";

      let availableCount = 0;

      data.forEach((q) => {
        if (!completed.includes(q.id)) {
          availableCount++;
          html += `<button class="quest-btn" data-id="${q.id}">${q.title}</button><br>`;
        }
      });

      if (availableCount === 0) {
        html += "<p>No available quests here.</p>";
      }

      openModal(html);
    })
    .catch((err) => console.error("Error loading quests:", err));
}

// Open a specific quest
function openQuest(id) {
  fetch(`/quest/${id}`)
    .then((res) => res.json())
    .then((q) => {
      const html = `
        <h3>${q.title}</h3>
        <p>${q.question}</p>
        <input type="text" id="answerInput" placeholder="Your answer">
        <button class="submit-btn" data-id="${q.id}">Submit</button>
        <p id="result"></p>
      `;

      openModal(html);
    })
    .catch((err) => console.error("Error loading quest:", err));
}

// Submit answer
function submitAnswer(id) {
  const input = document.getElementById("answerInput");
  if (!input) return;

  const answer = input.value;

  fetch("/submit", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ quest_id: id, answer: answer }),
  })
    .then((res) => res.json())
    .then((data) => {
      const resultEl = document.getElementById("result");

      if (data.correct) {
        let completed =
          JSON.parse(localStorage.getItem("quest_completed")) || [];

        if (!completed.includes(id)) {
          completed.push(id);
          localStorage.setItem("quest_completed", JSON.stringify(completed));
        }

        //================================================
        // CHECK IF ALL QUESTS ARE COMPLETED (WIN CONDITION)
        //========================================---------
        const locationId = localStorage.getItem("location_id");

        fetch(`/quests/${locationId}`)
          .then((res) => res.json())
          .then((allQuests) => {
            const completedNow =
              JSON.parse(localStorage.getItem("quest_completed")) || [];

            const allQuestIds = allQuests.map((q) => q.id);

            const allDone = allQuestIds.every((qid) =>
              completedNow.includes(qid),
            );

            if (allDone) {
              window.location.href = "/api/game/you-won";
            }
          });
      }

      if (resultEl) {
        resultEl.innerHTML = `<strong>${data.result}</strong>`;
      }
    })
    .catch((err) => {
      console.error("Error submitting answer:", err);
      const resultEl = document.getElementById("result");
      if (resultEl) resultEl.innerText = "Error submitting answer.";
    });
}

// Attach event listeners
document.addEventListener("DOMContentLoaded", () => {
  const showBtn = document.getElementById("showQuestsBtn");

  if (showBtn) {
    showBtn.addEventListener("click", loadQuests);
  }

  // Global click handler
  document.addEventListener("click", (e) => {
    // Close modal
    if (e.target && e.target.id === "closeModalQuest") {
      closeModal();
    }

    // Quest button click
    if (e.target && e.target.classList.contains("quest-btn")) {
      const id = e.target.getAttribute("data-id");
      openQuest(Number(id));
    }

    // Submit answer click
    if (e.target && e.target.classList.contains("submit-btn")) {
      const id = e.target.getAttribute("data-id");
      submitAnswer(Number(id));
    }
  });

  // Click outside modal closes it
  window.addEventListener("click", (e) => {
    const modal = document.getElementById("questModalQuest");
    if (modal && e.target === modal) {
      closeModal();
    }
  });

  // ESC closes modal
  document.addEventListener("keydown", (e) => {
    if (e.key === "Escape") {
      closeModal();
    }
  });
});
