alert("JS loaded");

function loadQuests() {
    fetch("/quests")
    .then(res => res.json())
    .then(data => {
        console.log(data);

        const list = document.getElementById("questList");
        list.innerHTML = "";

        data.forEach(q => {
            const btn = document.createElement("button");
            btn.innerText = q.title;
            btn.onclick = () => openQuest(q.id);
            list.appendChild(btn);
            list.appendChild(document.createElement("br"));
        });
    });
}
function openQuest(id) {
    fetch(`/quest/${id}`)
    .then(res => res.json())
    .then(q => {
        const panel = document.getElementById("questPanel");

        panel.innerHTML = `
            <h3>${q.title}</h3>
            <p>${q.question}</p>

            <input type="text" id="answerInput" placeholder="Your answer">
            <button onclick="submitAnswer(${q.id})">Submit</button>

            <p id="result"></p>
        `;
    });
}

function submitAnswer(id) {
    const answer = document.getElementById("answerInput").value;

    fetch("/submit", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            quest_id: id,
            answer: answer
        })
    })
    .then(res => res.json())
    .then(data => {
        document.getElementById("result").innerHTML =
            `<strong>${data.result}</strong> (XP: ${data.xp})`;
    });
}