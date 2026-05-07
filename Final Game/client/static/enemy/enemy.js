class Enemy {
  constructor() {
    this.frameX = 0;
    this.frameY = 0;

    this.fps = 10;
    this.frameTimer = 0;
    this.frameInterval = 1000 / this.fps;

    this.speedX = 0;
    this.baseSpeedX = 0;

    this.state = "walk"; // Walking state initially
    this.hitCooldown = false;

    this.direction = "left";

    this.isDead = false; // Flag to check if the enemy is dead
  }

  setState(state, config) {
    this.state = state;
    this.frameX = 0;

    if (config) {
      this.image = config.image;
      this.maxFrame = config.frames;
      this.speedX = config.speed ?? this.speedX;
    }
  }

  update(deltaTime) {
    if (this.isDead) return; // Skip update if the enemy is dead

    this.x -= this.speedX;
    this.frameTimer += deltaTime;

    while (this.frameTimer >= this.frameInterval) {
      this.frameTimer -= this.frameInterval;
      this.frameX++;

      if (this.frameX >= this.maxFrame) {
        this.frameX = 0;

        if (this.state === "attack") this.enterWalk();
        if (this.state === "hurt") this.enterWalk();
      }
    }
  }

  hitbox() {
    return {
      x: this.x,
      y: this.y + 10,
      width: this.width,
      height: this.height - 20,
    };
  }

  checkCollision(player) {
    if (this.isDead || this.state === "hurt") return false; // Skip collision check if dead or hurt

    const hb = this.hitbox();

    return (
      hb.x < player.x + player.drawWidth + this.game.cameraX - 40 &&
      hb.x + hb.width > player.x + this.game.cameraX - 40 &&
      hb.y < player.y + player.height &&
      hb.y + hb.height > player.y
    );
  }

  draw(ctx) {
    if (this.isDead) return; // Skip drawing if the enemy is dead

    // if (this.game.debug) {
    //   ctx.strokeRect(this.x, this.y, this.width, this.height);
    // }

    ctx.save();

    ctx.translate(this.x + this.width / 2, this.y + this.height / 2);

    if (this.direction === "left") {
      ctx.scale(-1, 1);
    }

    ctx.drawImage(
      this.image,
      this.frameX * this.width,
      0,
      this.width,
      this.height,
      -this.width / 2,
      -this.height / 2,
      this.width,
      this.height,
    );

    ctx.restore();
  }

  attack() {
    if (this.state !== "walk") return;
  }

  onHit() {
    if (this.hitCooldown) return;

    this.hitCooldown = true;

    // Set the enemy to "die" state and mark it as dead

    setTimeout(() => {
      this.hitCooldown = false;
      this.enterWalk();
    }, 600);
  }
}
export class DesertEnemy extends Enemy {
  constructor(game) {
    super();

    this.game = game;

    this.width = 192;
    this.height = 128;

    this.x = game.width;
    this.y = 520;

    this.pad = 30;

    this.baseSpeedX = Math.floor(Math.random() * 2) + 1;
    this.speedX = this.baseSpeedX; // Fixed the typo here: changed aseSpeedX to baseSpeedX

    this.walkImage = new Image();
    this.walkImage.src = "../static/images/enemySprite1/walk.png";

    this.atkImage = new Image();
    this.atkImage.src = "../static/images/enemySprite1/atk1.png";

    this.hurtImage = new Image();
    this.hurtImage.src = "../static/images/enemySprite1/hurt.png";

    this.deadImage = new Image(); // New dead image
    this.deadImage.src = "../static/images/enemySprite1/die.png"; // Add path to dead sprite

    this.enterWalk();

    // New property to track hits
    this.hitCount = 0; // Start with 0 hits
    this.maxHits = 3; // Set the number of hits before death (adjust as necessary)
  }

  enterWalk() {
    this.setState("walk", {
      image: this.walkImage,
      frames: 10,
      speed: this.baseSpeedX,
    });
  }

  attack() {
    if (this.state !== "walk") return;

    this.setState("attack", {
      image: this.atkImage,
      frames: 9,
      speed: 0,
    });
  }

  onHit() {
    if (this.hitCooldown || this.isDead) return; // Prevent further actions if dead

    this.hitCooldown = true;

    // Increment hit count each time the enemy is hit
    this.hitCount++;

    // If the enemy has taken enough hits, mark it as dead
    if (this.hitCount >= this.maxHits) {
      this.setState("dead", {
        image: this.deadImage,
        frames: 13, // Dead state usually doesn't need animation, so 1 frame
        speed: 0,
      });

      // After the dead animation, mark the enemy as truly dead
      setTimeout(() => {
        this.isDead = true;
      }, 500); // Adjust the delay to match dead animation length
      return true;
    } else {
      // If the enemy hasn't taken enough hits yet, just play the hurt animation
      this.setState("hurt", {
        image: this.hurtImage,
        frames: 5,
        speed: 0,
      });

      setTimeout(() => {
        this.hitCooldown = false;
        this.enterWalk();
      }, 500); // Re-enable movement after the hurt animation
    }
  }

  update(deltaTime, player) {
    super.update(deltaTime, player);
  }
}
export class FlyingImp extends Enemy {
  constructor(game) {
    super();

    this.game = game;

    this.width = 146.5;
    this.height = 128;

    this.x = game.width;
    this.y = 490;

    this.pad = 30;

    this.baseSpeedX = Math.floor(Math.random() * 2) + 1.2;
    this.speedX = this.baseSpeedX; // Fixed typo: aseSpeedX to baseSpeedX

    this.walkImage = new Image();
    this.walkImage.src = "../static/images/enemySprite2/walk.png";

    this.atkImage = new Image();
    this.atkImage.src = "../static/images/enemySprite2/atk1.png";

    this.hurtImage = new Image();
    this.hurtImage.src = "../static/images/enemySprite2/hurt.png";

    this.deadImage = new Image(); // New dead image
    this.deadImage.src = "../static/images/enemySprite2/die.png"; // Add path to dead sprite

    this.enterWalk();

    // New properties to track hits
    this.hitCount = 0;
    this.maxHits = 3; // Adjust this value as needed
  }

  enterWalk() {
    this.setState("walk", {
      image: this.walkImage,
      frames: 4,
      speed: this.baseSpeedX,
    });
  }

  attack() {
    if (this.state !== "walk") return;

    this.setState("attack", {
      image: this.atkImage,
      frames: 8,
      speed: 0,
    });
  }

  onHit() {
    if (this.hitCooldown || this.isDead) return; // Prevent further actions if dead

    this.hitCooldown = true;

    // Increment hit count each time the enemy is hit
    this.hitCount++;

    // If the enemy has taken enough hits, mark it as dead
    if (this.hitCount >= this.maxHits) {
      this.setState("dead", {
        image: this.deadImage,
        frames: 7, // Dead state usually doesn't need animation, so 1 frame
        speed: 0,
      });

      // After the dead animation, mark the enemy as truly dead
      setTimeout(() => {
        this.isDead = true;
        return true;
      }, 600); // Adjust delay based on animation length
      return true;
    } else {
      // If the enemy hasn't taken enough hits yet, just play the hurt animation
      this.setState("hurt", {
        image: this.hurtImage,
        frames: 4,
        speed: 0,
      });

      setTimeout(() => {
        this.hitCooldown = false;
        this.enterWalk();
      }, 600); // Re-enable movement after the hurt animation
    }
  }

  update(deltaTime, player) {
    super.update(deltaTime, player);
  }
}
export class DeathKnight extends Enemy {
  constructor(game) {
    super();

    this.game = game;

    this.width = 141;
    this.height = 177;

    this.x = game.width;
    this.y = 520;

    this.pad = 30;

    this.baseSpeedX = Math.floor(Math.random() * 2) + 1.2;
    this.speedX = this.baseSpeedX; // Fixed typo: aseSpeedX to baseSpeedX

    this.walkImage = new Image();
    this.walkImage.src = "../static/images/enemySprite3/walk.png";

    this.atkImage = new Image();
    this.atkImage.src = "../static/images/enemySprite3/atk1.png";

    this.hurtImage = new Image();
    this.hurtImage.src = "../static/images/enemySprite3/hurt.png";

    this.deadImage = new Image(); // New dead image
    this.deadImage.src = "../static/images/enemySprite3/die.png"; // Add path to dead sprite

    this.enterWalk();

    // New properties to track hits
    this.hitCount = 0;
    this.maxHits = 3; // Adjust this value as needed
  }

  enterWalk() {
    this.setState("walk", {
      image: this.walkImage,
      frames: 9,
      speed: this.baseSpeedX,
    });
  }

  attack() {
    if (this.state !== "walk") return;

    this.setState("attack", {
      image: this.atkImage,
      frames: 12,
      speed: 0,
    });
  }

  onHit() {
    if (this.hitCooldown || this.isDead) return; // Prevent further actions if dead

    this.hitCooldown = true;

    // Increment hit count each time the enemy is hit
    this.hitCount++;

    // If the enemy has taken enough hits, mark it as dead
    if (this.hitCount >= this.maxHits) {
      this.setState("dead", {
        image: this.deadImage,
        frames: 22, // Dead state usually doesn't need animation, so 1 frame
        speed: 0,
      });

      // After the dead animation, mark the enemy as truly dead
      setTimeout(() => {
        this.isDead = true;
      }, 700); // Adjust delay based on animation length
      return true;
    } else {
      // If the enemy hasn't taken enough hits yet, just play the hurt animation
      this.setState("hurt", {
        image: this.hurtImage,
        frames: 4,
        speed: 0,
      });

      setTimeout(() => {
        this.hitCooldown = false;
        this.enterWalk();
      }, 600); // Re-enable movement after the hurt animation
    }
  }

  update(deltaTime, player) {
    super.update(deltaTime, player);
  }
}
