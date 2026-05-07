// Element references
const menuView = document.querySelector("#menuView");
const charView = document.querySelector("#charView");
const locationView = document.querySelector("#locationView");

const createCharBtn = document.querySelector("#createCharBtn");
const cancelBtn = document.querySelector("#cancelBtn");
const startCharBtn = document.querySelector("#startCharBtn");
const charNameInput = document.querySelector("#charName");

// Helper function to toggle views
function showView(viewToShow) {
  [menuView, charView, locationView].forEach((view) => {
    view.style.display = view === viewToShow ? "block" : "none";
  });
}

// Show character creation form
createCharBtn.addEventListener("click", () => {
  showView(charView);
});

// Back to menu
cancelBtn.addEventListener("click", () => {
  showView(menuView);
});

// Show location selection after entering character name
startCharBtn.addEventListener("click", () => {
  const charName = charNameInput.value.trim();

  if (!charName) {
    alert("Please enter a character name");
    return;
  }

  localStorage.setItem("character_name", charName);

  const save_id = localStorage.getItem("save_id");
  if (!save_id) {
    alert("User not logged in");
    return;
  }

  // Simply reveal locationView for now
  showView(locationView);
});

// Handle location button clicks and create character with chosen empire
document.querySelectorAll(".location-btn").forEach((button) => {
  button.addEventListener("click", async () => {
    const chosenEmpire = button.dataset.empire;
    const route = button.dataset.route;

    const charName = localStorage.getItem("character_name");
    const save_id = localStorage.getItem("save_id");

    if (!charName || !save_id) {
      alert("Character name or user save ID is missing.");
      return;
    }

    // If character_id already exists in localStorage, use it, otherwise generate one
    let character_id =
      localStorage.getItem("character_id") || crypto.randomUUID();

    // Store empire in localStorage
    localStorage.setItem("chosen_empire", chosenEmpire);

    try {
      const res = await fetch("/characters/create", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          save_id,
          character_name: charName,
          empire: chosenEmpire,
          character_id, // include character_id in the request body
        }),
      });

      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to create character");

      // Save returned character_id (if server generates its own) or use ours
      localStorage.setItem("character_id", data.character_id || character_id);

      // Log everything
      console.log({
        save_id,
        charName,
        chosenEmpire,
        character_id: data.character_id || character_id,
      });

      window.location.href = route;
    } catch (err) {
      console.log("This is error line");
      console.error(err);
      console.log(err);
    }
  });
});
