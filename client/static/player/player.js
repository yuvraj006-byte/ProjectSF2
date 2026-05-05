import {
  Idle,
  Walk,
  Attack,
  Run,
  Defend,
  getKeyPress,
  Hurt,
} from "./states.js";

export default class Player {
  constructor(game) {
    this.game = game;
    this.width = 192;
    this.height = 168;
    this.image = new Image();
    this.states = {
      STANDING: new Idle(this),
      WALKING: new Walk(this),
      RUN: new Run(this),
      DEFEND: new Defend(this),
      ATK_1: new Attack(this, "ATK_1"),
      ATK_2: new Attack(this, "ATK_2"),
      ATK_3: new Attack(this, "ATK_3"),
      HURT: new Hurt(this),
    };
    this.currentState = this.states.STANDING;
    this.currentState.enter();
    this.scale = 1;
    this.x = game.width / 2 - this.width / 2;
    this.y = game.height - this.height;
    this.frameX = 0;
    this.frameY = 0;
    this.padding = 30;
    this.drawWidth = this.width - this.padding * 2 - 30;
    this.drawHeight = this.height - this.padding * 2;
    this.speedX = 0;
    this.maxSpeedX = 2;
    this.runMultiplier = 2;
    this.direction = "right";
    this.hurtCooldown = 3000;
    this.lastHitTime = 0;
    this.fps = 10;
    this.frameTimer = 0;
    this.frameInterval = 1000 / this.fps;

    // --- HEALTH ---
    this.health = 100; // Current HP
    this.maxHealth = 100; // Max HP
  }

  onHit() {
    const now = Date.now();
    if (now - this.lastHitTime < this.hurtCooldown) return;

    if (this.currentState === this.states.DEFEND) return;
    if (this.currentState === this.states.HURT) return;

    this.lastHitTime = now;
    this.setState("HURT");

    this.health = Math.max(0, this.health - 10); // decrease health by 1
    this.updateHealthDisplay();

    if (this.health <= 0) {
      console.log("Player is dead!");
      window.location.href = "/api/game/you-died";
      // Optionally, trigger game over logic here
    }
  }

  updateHealthDisplay() {
    const hpText = document.getElementById("healthText");
    const healthBar = document.getElementById("healthBar");

    if (hpText) hpText.textContent = `${this.health} / ${this.maxHealth}`;

    if (healthBar) {
      const hpPercent = (this.health / this.maxHealth) * 100;
      healthBar.style.width = hpPercent + "%";

      // Change color based on health
      if (hpPercent > 60) {
        healthBar.style.background = "green";
      } else if (hpPercent > 30) {
        healthBar.style.background = "orange";
      } else {
        healthBar.style.background = "red";
      }
    }
  }

  setState(stateKey) {
    if (this.currentState !== this.states[stateKey]) {
      this.currentState = this.states[stateKey];
      this.currentState.enter();
      this.drawWidth = this.width - this.padding * 2;
      this.drawHeight = this.height - this.padding * 2;
    }
  }

  draw(context, deltaTime) {
    if (this.width === 0 || this.height === 0) return;

    if (this.frameTimer >= this.frameInterval) {
      if (this.frameX < this.maxFrame - 1) this.frameX++;
      else this.frameX = 0;
      this.frameTimer = 0;
    } else {
      this.frameTimer += deltaTime;
    }

    context.save();
    if (this.direction === "left") {
      context.translate(
        this.x + this.game.cameraX + this.drawWidth * this.scale,
        this.y,
      );
      context.scale(-1, 1);
      context.drawImage(
        this.image,
        this.frameX * this.width + this.padding,
        this.frameY * this.height + this.padding,
        this.drawWidth,
        this.drawHeight,
        0,
        0,
        this.drawWidth * this.scale,
        this.drawHeight * this.scale,
      );
    } else {
      context.drawImage(
        this.image,
        this.frameX * this.width + this.padding,
        this.frameY * this.height + this.padding,
        this.drawWidth,
        this.drawHeight,
        this.x + this.game.cameraX,
        this.y,
        this.drawWidth * this.scale,
        this.drawHeight * this.scale,
      );
    }
    context.restore();
  }

  update(inputHandler) {
    const input = {
      handler: inputHandler,
      ...getKeyPress(inputHandler.keys),
    };

    this.currentState.handleInput(input);

    if (this.x < 0) this.x = 0;

    if (this.x + this.drawWidth * this.scale > this.game.world.width) {
      this.x = this.game.world.width - this.drawWidth * this.scale;
    }
  }
}
