console.log("backGround/script.js Loaded!");
let layers = [];

function createImage(src) {
  return new Promise((resolve, reject) => {
    const img = new Image();
    img.src = src;

    img.onload = () => resolve(img);
    img.onerror = () => reject(`Failed to load: ${src}`);
  });
}

async function fetchBackground(name) {
  const res = await fetch(`/api/background/${name}`, {
    credentials: "include",
  });

  if (!res.ok) {
    throw new Error("Failed to fetch background");
  }

  return await res.json();
}

export async function loadBackground(name) {
  try {
    const urls = await fetchBackground(name);
    // console.log("BG URLs:", urls);

    layers = await Promise.all(urls.map((src) => createImage(src)));

    console.log("Loaded layers:", layers.length);
  } catch (err) {
    console.error(err);
    layers = [];
  }
}
export function drawBackground(ctx, width, height, cameraX) {
  if (layers.length === 0) return;

  layers.forEach((img, i) => {
    const depth = 0.3 + i * 0.3;
    const imgWidth = width;

    let x = (cameraX * depth) % imgWidth;
    if (x > 0) x -= imgWidth;

    for (let j = 0; j < 3; j++) {
      ctx.drawImage(img, x + j * imgWidth, 0, imgWidth, height);
    }
  });
}

window.addEventListener("load", () => {
  const screen = document.querySelector("#transitionScreen");
  const text = document.querySelector("#transitionText");

  const hasTransition = sessionStorage.getItem("transition");

  if (hasTransition) {
    // restore message
    const savedText = sessionStorage.getItem("transitionText");
    if (savedText && text) {
      text.textContent = savedText;
    }

    // clear storage
    sessionStorage.removeItem("transition");
    sessionStorage.removeItem("transitionText");

    // fade out
    setTimeout(() => {
      screen.classList.remove("active");
    }, 300);
  } else {
    // no transition → hide instantly
    screen.classList.remove("active");
  }
});

console.log("Inventory system loaded");
