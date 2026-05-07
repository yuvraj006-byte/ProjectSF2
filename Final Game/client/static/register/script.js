// register Form
console.log("register/script.js");

document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("registerForm");

  form.addEventListener("submit", async (e) => {
    e.preventDefault();

    const formData = new FormData(form);

    try {
      const response = await fetch("/auth/register", {
        method: "POST",
        body: formData,
      });

      const data = await response.json();

      // Handle backend errors properly (e.g. user already exists)
      const messageBox = document.getElementById("formMessage");

      if (!response.ok) {
        messageBox.textContent = data.message || "Request failed";
        messageBox.style.color = "red";
        return;
      }

      // Success
      messageBox.textContent = data.message || "Registration successful!";
      messageBox.style.color = "green";
      setTimeout(() => {
        window.location.href = "/";
      }, 1500);

      // Success
    } catch (err) {
      console.error(err);
      console.log(err.message);
    }
  });
});
