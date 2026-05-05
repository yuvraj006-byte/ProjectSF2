const openMap = document.querySelector("#openMap");
openMap?.addEventListener("click", (evt) => {
  evt.preventDefault();
  window.location.href = "/map";
});

import Game from "./game.js";

window.addEventListener("load", async () => {
  const canvas = document.querySelector("#gameCanvas");

  canvas.width = 850;
  canvas.height = 720;

  const game = new Game(canvas);
  await game.init();

  // --- Sync initial health with stats from modal fields ---
  const cHp = parseInt(document.getElementById("c_hp")?.textContent);
  const cMaxHp = parseInt(document.getElementById("c_max_hp")?.textContent);
  if (!isNaN(cHp) && !isNaN(cMaxHp)) {
    game.player.health = cHp;
    game.player.maxHealth = cMaxHp;
    game.player.updateHealthDisplay();
  }

  game.loop(0);

  window.addEventListener("resize", () => {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
  });
});

const characterId = localStorage.getItem("character_id");

const modal = document.getElementById("statsModal");
const statsBtn = document.getElementById("statsBtn");
const closeBtn = document.getElementById("closeStats");

statsBtn.addEventListener("click", async () => {
  try {
    if (!characterId) {
      alert("No character selected");
      return;
    }

    const res = await fetch(`/characters/player/${characterId}`);

    if (!res.ok) {
      const text = await res.text();
      console.error("Server error:", text);
      alert("Failed to load character stats");
      return;
    }

    const data = await res.json();

    if (data.error) {
      alert(data.error);
      return;
    }
    const locationId = sessionStorage.getItem("location_id");
    // Basic stats
    console.log("getting stats");
    document.getElementById("c_name").textContent = data.name;
    document.getElementById("c_attack").textContent = data.attack;
    document.getElementById("c_defense").textContent = data.defense;

    document.getElementById("c_location").textContent = locationId;

    // --- HEALTH DISPLAY ---

    // Text display (HP / Max HP)
    document.getElementById("healthText").textContent =
      `${data.hp} / ${data.max_hp}`;
    console.log("HP:", data.hp, "MAX:", data.max_hp);

    // Optional: keep separate fields too

    document.getElementById("c_max_hp").textContent = data.max_hp;

    // Health bar calculation
    const hpPercent = (data.hp / data.max_hp) * 100;

    const healthBar = document.getElementById("healthBar");
    if (healthBar) {
      healthBar.style.width = hpPercent + "%";

      // Optional: change color based on health
      if (hpPercent > 60) {
        healthBar.style.background = "green";
      } else if (hpPercent > 30) {
        healthBar.style.background = "orange";
      } else {
        healthBar.style.background = "red";
      }
    }

    // Show modal
    modal.style.display = "flex";
  } catch (err) {
    console.error(err);
  }
});

closeBtn.addEventListener("click", () => {
  modal.style.display = "none";
});

// Click outside modal closes it
modal.addEventListener("click", (e) => {
  if (e.target === modal) {
    modal.style.display = "none";
  }
});
