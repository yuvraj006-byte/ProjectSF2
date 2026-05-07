import { ACTION_KEYS } from "../inputs/action.js";

// --- CONFIG ---

const imgDimension = {
  WIDTH: 192,
  HEIGHT: 168,
};

const baseConfig = {
  width: imgDimension.WIDTH,
  height: imgDimension.HEIGHT,
};

export const stateConfig = {
  STANDING: {
    ...baseConfig,
    maxFrame: 6,
    image: "../static/images/playerSprite/IDLE.png",
  },
  WALKING: {
    ...baseConfig,
    maxFrame: 7,
    image: "../static/images/playerSprite/WALK.png",
  },
  RUN: {
    ...baseConfig,
    maxFrame: 7,
    image: "../static/images/playerSprite/RUN.png",
  },
  DEFEND: {
    ...baseConfig,
    maxFrame: 5,
    image: "../static/images/playerSprite/DEFEND.png",
  },

  ATK_1: {
    ...baseConfig,
    maxFrame: 5,
    image: "../static/images/playerSprite/ATTACK 1.png",
  },
  ATK_2: {
    ...baseConfig,
    maxFrame: 4,
    image: "../static/images/playerSprite/ATTACK 2.png",
  },
  ATK_3: {
    ...baseConfig,
    maxFrame: 5,
    image: "../static/images/playerSprite/ATTACK 3.png",
  },
  HURT: {
    ...baseConfig,
    maxFrame: 4,
    image: "../static/images/playerSprite/HURT.png",
  },
};

// --- INPUT HELPER ---

export const getKeyPress = (keys) => ({
  right: keys.includes(ACTION_KEYS.RIGHT),
  left: keys.includes(ACTION_KEYS.LEFT),
  shift: keys.includes(ACTION_KEYS.SHIFTL) || keys.includes(ACTION_KEYS.SHIFTR),
  atk1: keys.includes(ACTION_KEYS.ATK_1),
  atk2: keys.includes(ACTION_KEYS.ATK_2),
  atk3: keys.includes(ACTION_KEYS.ATK_3),
  defend: keys.includes(ACTION_KEYS.DEFEND),
});

// --- SMALL HELPERS ---

function updateDirection(character, input) {
  if (input.right && !input.left) character.direction = "right";
  else if (input.left && !input.right) character.direction = "left";
}

// --- BASE STATE ---

class State {
  constructor(character, key) {
    this.character = character;
    this.key = key;
  }

  applyConfig() {
    const config = stateConfig[this.key];
    this.character.image.src = config.image;
    this.character.width = config.width;
    this.character.height = config.height;
    this.character.frameX = 0;
    this.character.maxFrame = config.maxFrame;
  }
}

// --- STATES ---

export class Idle extends State {
  constructor(character) {
    super(character, "STANDING");
  }

  enter() {
    this.applyConfig();
    this.character.speedX = 0;
  }

  handleInput(input) {
    updateDirection(this.character, input);

    if (input.defend) return this.character.setState("DEFEND");
    if (input.atk1) return this.character.setState("ATK_1");
    if (input.atk2) return this.character.setState("ATK_2");
    if (input.atk3) return this.character.setState("ATK_3");

    const moving = input.left || input.right;

    if (input.shift && moving) return this.character.setState("RUN");
    if (moving) return this.character.setState("WALKING");
  }
}

export class Walk extends State {
  constructor(character) {
    super(character, "WALKING");
  }

  enter() {
    this.applyConfig();
    this.character.speedX = this.character.maxSpeedX;
  }

  handleInput(input) {
    updateDirection(this.character, input);

    // shared transitions
    if (input.defend) return this.character.setState("DEFEND");
    if (input.atk1) return this.character.setState("ATK_1");
    if (input.atk2) return this.character.setState("ATK_2");
    if (input.atk3) return this.character.setState("ATK_3");

    const moving = input.left || input.right;

    if (!moving) return this.character.setState("STANDING");
    if (input.shift) return this.character.setState("RUN");

    if (input.right && !input.left) this.character.x += this.character.speedX;
    else if (input.left && !input.right)
      this.character.x -= this.character.speedX;
  }
}

export class Run extends State {
  constructor(character) {
    super(character, "RUN");
  }

  enter() {
    this.applyConfig();
    this.character.speedX =
      this.character.maxSpeedX * this.character.runMultiplier;
  }

  handleInput(input) {
    updateDirection(this.character, input);

    const moving = input.left || input.right;

    if (!moving) return this.character.setState("STANDING");
    if (!input.shift) return this.character.setState("WALKING");

    if (input.right && !input.left) this.character.x += this.character.speedX;
    else if (input.left && !input.right)
      this.character.x -= this.character.speedX;
  }
}

// --- GENERIC ATTACK STATE ---

export class Attack extends State {
  constructor(character, key) {
    super(character, key);
  }

  enter() {
    this.applyConfig();
  }

  handleInput(input) {
    if (this.character.frameX >= this.character.maxFrame - 1) {
      input.handler.resetAttack();
      this.character.setState("STANDING");
    }
  }
}

// --- DEFEND ---

export class Defend extends State {
  constructor(character) {
    super(character, "DEFEND");
  }

  enter() {
    this.applyConfig();
  }

  handleInput(input) {
    if (!input.defend) {
      this.character.setState("STANDING");
    }
  }
}

export class Hurt extends State {
  constructor(character) {
    super(character, "HURT");
  }

  enter() {
    this.applyConfig();
    this.character.speedX = 0; // optional: stop movement
  }

  handleInput(input) {
    updateDirection(this.character, input);

    if (input.defend) return this.character.setState("DEFEND");
    if (input.atk1) return this.character.setState("ATK_1");
    if (input.atk2) return this.character.setState("ATK_2");
    if (input.atk3) return this.character.setState("ATK_3");

    const moving = input.left || input.right;

    if (input.shift && moving) return this.character.setState("RUN");
    if (moving) return this.character.setState("WALKING");
  }
}
