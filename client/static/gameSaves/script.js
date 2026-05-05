const menuView = document.getElementById("menuView");
const newWorldView = document.getElementById("newWorldView");

const newWorldBtn = document.getElementById("newWorldBtn");
const cancelBtn = document.getElementById("cancelBtn");

const startWorldBtn = document.getElementById("startWorldBtn");

// Switch to form
newWorldBtn.addEventListener("click", () => {
  menuView.style.display = "none";
  newWorldView.style.display = "block";
});

// Back to menu
cancelBtn.addEventListener("click", () => {
  newWorldView.style.display = "none";
  menuView.style.display = "block";
});

// Start world
startWorldBtn.addEventListener("click", async () => {
  const saveName = document.getElementById("worldName").value.trim();

  if (!saveName) {
    alert("Please enter a world name");
    return;
  }

  // You already stored this after login earlier
  const user_id = localStorage.getItem("user_id");

  if (!user_id) {
    alert("User not logged in");
    return;
  }

  try {
    const res = await fetch("/saves/create", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        user_id: user_id,
        save_name: saveName,
      }),
    });

    const data = await res.json();

    if (!res.ok) {
      throw new Error(data.error || "Failed to create save");
    }

    console.log("Save created:", data);

    // store save id for later gameplay
    localStorage.setItem("save_id", data.save_id);

    // go to game
    window.location.href = "/characters/create-page";
  } catch (err) {
    console.error(err);
    alert(err.message);
  }
});
