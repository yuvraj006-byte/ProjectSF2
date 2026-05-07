export default class InputHandler {
  constructor(game) {
    this.game = game;
    this.keys = [];
    this.isAttacking = false;

    window.addEventListener("keydown", (e) => {
      const key = e.code;

      switch (key) {
        case "ArrowRight":
        case "ArrowLeft":

        case "KeyQ":
        case "KeyW":
        case "KeyE":
        case "Space":
        case "ShiftLeft":
        case "ShiftRight":
        case "KeyR":
          if (!this.keys.includes(key)) {
            this.keys.push(key);
          }

          if (
            (key === "KeyQ" ||
              key === "KeyW" ||
              key === "KeyE" ||
              key === "Space" ||
              key === "KeyR") &&
            !this.isAttacking
          ) {
            this.isAttacking = true;
          }
          break;
      }
    });

    window.addEventListener("keyup", (e) => {
      const key = e.code;

      switch (key) {
        case "ArrowRight":
        case "ArrowLeft":

        case "KeyQ":
        case "KeyW":
        case "KeyE":
        case "Space":
        case "ShiftLeft":
        case "ShiftRight":
        case "KeyR":
          const index = this.keys.indexOf(key);
          if (index > -1) {
            this.keys.splice(index, 1);
          }
          break;
      }
    });
  }

  resetAttack() {
    this.isAttacking = false;
  }
}
