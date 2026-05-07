const homeBtn = document.querySelector("#home");

const register = document.querySelector("#register");
const enterBattleBtn = document.querySelector("#enterBattleBtn");

// HOME
homeBtn?.addEventListener("click", (evt) => {
  evt.preventDefault();
  window.location.href = "/";
});

// LOGIN
enterBattleBtn?.addEventListener("click", (evt) => {
  evt.preventDefault();
  window.location.href = "/login_page";
});

// REGISTER
register?.addEventListener("click", (evt) => {
  evt.preventDefault();
  window.location.href = "/register_page";
});
