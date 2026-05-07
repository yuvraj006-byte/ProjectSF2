import Player from "./player/player.js";
import InputHandler from "./inputs/input.js";
import { loadBackground, drawBackground } from "./backGround/script.js";
import { DesertEnemy, FlyingImp, DeathKnight } from "./enemy/enemy.js";

export default class Game {
  constructor(canvas) {
    this.canvas = canvas;
    this.ctx = canvas.getContext("2d");

    this.width = canvas.width;
    this.height = canvas.height;

    this.world = {
      width: 6000,
      height: canvas.height,
    };

    this.player = new Player(this);
    this.inputHandler = new InputHandler(this);

    this.enemies = [];
    this.maxEnemies = 3;

    this.enemyTimer = 0;
    this.enemyInterval = 1500;
    this.killCountElement = document.getElementById("killCount");

    this.lastTime = 0;
    this.cameraX = 0;

    //  LOCATION ID (drives everything)
    const locationId = sessionStorage.getItem("location_id") || "default";

    //  KILL SYSTEM (per region)
    this.killKey = `kills_${locationId}`;
    this.enemiesKilled = parseInt(sessionStorage.getItem(this.killKey)) || 0;
    this.killCountElement.textContent = this.enemiesKilled;

    //  SPAWN SYSTEM (per region)
    this.spawnKey = `spawns_${locationId}`;
    this.maxKey = `max_${locationId}`;

    this.totalSpawned = parseInt(sessionStorage.getItem(this.spawnKey)) || 0;
    this.maxRegionEnemies = parseInt(sessionStorage.getItem(this.maxKey)) || 10;
    sessionStorage.setItem(this.maxKey, this.maxRegionEnemies);

    this.noMoreEnemiesAlerted = false; //  flag to show message only once

    this.debug = true;
    this.enemyTypes = [DesertEnemy, FlyingImp, DeathKnight];
  }

  async init() {
    const empire = document.body.dataset.empire.toLowerCase();
    await loadBackground(empire);
  }

  update(deltaTime) {
    // Remove dead enemies
    this.enemies = this.enemies.filter((enemy) => !enemy.isDead);

    // Player update
    this.player.update(this.inputHandler, deltaTime);

    // Camera logic
    this.cameraX = -this.player.x + this.canvas.width / 2;
    this.cameraX = Math.min(0, this.cameraX);
    this.cameraX = Math.max(
      -(this.world.width - this.canvas.width),
      this.cameraX,
    );

    // Enemy spawning
    this.enemyTimer += deltaTime;
    if (this.enemyTimer > this.enemyInterval) {
      this.addEnemy();
      this.enemyTimer = 0;
    }

    // Enemy update & collision
    this.enemies.forEach((enemy) => {
      enemy.update(deltaTime, this.player, this.cameraX);

      const isColliding = enemy.checkCollision(this.player, this.cameraX);

      if (isColliding && this.inputHandler.isAttacking) {
        if (enemy.onHit()) {
          this.enemiesKilled++;
          this.killCountElement.textContent = this.enemiesKilled;

          //  Save kills per region
          sessionStorage.setItem(this.killKey, this.enemiesKilled);
        }
        this.inputHandler.resetAttack();
      }

      if (isColliding) {
        enemy.attack();
        this.player.onHit();
      }
    });

    //  Check if all enemies for this region are done
    if (
      this.totalSpawned >= this.maxRegionEnemies &&
      this.enemies.length === 0 &&
      !this.noMoreEnemiesAlerted
    ) {
      this.noMoreEnemiesAlerted = true;
      document.querySelector("#killmsg").textContent =
        "No More enemies to Kill!";
    }
  }

  draw(deltaTime) {
    this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);

    drawBackground(
      this.ctx,
      this.canvas.width,
      this.canvas.height,
      this.cameraX,
    );

    this.player.draw(this.ctx, deltaTime, this.cameraX, 0);

    this.enemies.forEach((enemy) => {
      if (!enemy.isDead) {
        enemy.draw(this.ctx);
      }
    });
  }

  addEnemy() {
    // Stop spawning after region limit
    if (this.totalSpawned >= this.maxRegionEnemies) return;

    // Keep max 3 alive at once
    if (this.enemies.length >= this.maxEnemies) return;

    const EnemyType =
      this.enemyTypes[Math.floor(Math.random() * this.enemyTypes.length)];

    const newEnemy = new EnemyType(this);
    this.enemies.push(newEnemy);

    // Track spawn count per region
    this.totalSpawned++;
    sessionStorage.setItem(this.spawnKey, this.totalSpawned);
  }

  loop = (timeStamp) => {
    const deltaTime = Math.min(timeStamp - this.lastTime, 100);
    this.lastTime = timeStamp;

    this.update(deltaTime);
    this.draw(deltaTime);

    requestAnimationFrame(this.loop);
  };
}
