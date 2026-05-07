document.addEventListener("DOMContentLoaded", () => {
  const loginForm = document.getElementById("loginForm");

  const errorBox = document.getElementById("errorBox");
  const errorText = document.getElementById("errorText");
  const retryBtn = document.getElementById("retryBtn");
  const registerBtn = document.getElementById("registerBtn");

  function hideError() {
    errorBox.classList.add("hidden");
  }

  function showAccountNotFoundError() {
    errorText.textContent = "Account not found.";
    errorBox.classList.remove("hidden");
  }

  function showGenericError(message) {
    errorText.textContent = message;
    errorBox.classList.remove("hidden");
  }

  retryBtn.addEventListener("click", () => {
    hideError();
    loginForm.requestSubmit();
  });

  registerBtn.addEventListener("click", () => {
    window.location.href = "/register_page";
  });

  loginForm.addEventListener("submit", async (e) => {
    e.preventDefault();
    hideError();

    const formData = new FormData(loginForm);

    try {
      const response = await fetch("/auth/login", {
        method: "POST",
        body: formData,
      });

      const data = await response.json();

      if (!response.ok) {
        const msg = (data.message || "").toLowerCase();

        if (msg.includes("user not found")) {
          showAccountNotFoundError();
          return;
        }

        throw new Error(data.message || "Login failed");
      }

      const user_id = data.user_id;
      localStorage.setItem("user_id", user_id);

      window.location.href = "/saves/saves-page";
    } catch (err) {
      console.error(err);
      showGenericError(err.message);
    }
  });
});
