console.log("MAP SCRIPT LOADED");

const canvas = document.querySelector("#mapCanvas");
if (!canvas) {
  console.warn("Map canvas not found");
} else {
  const ctx = canvas.getContext("2d");

  const CANVAS_WIDTH = (canvas.width = 850);
  const CANVAS_HEIGHT = (canvas.height = 720);

  const maps = {
    main: {
      img: "../static/images/mapImages/Mapv2.png",
      regions: [
        {
          name: "Mustafar",
          x1: 67.4,
          y1: 74.4,
          x2: 366.4,
          y2: 318.4,
          target: "mustafar",
          location: "/Mustafar", // <-- new
        },
        {
          name: "Kamino",
          x1: 483.4,
          y1: 58.4,
          x2: 790.4,
          y2: 320.4,
          target: "kamino",
          location: "/Kamino", // <-- new
        },
        {
          name: "Genosis",
          x1: 37.4,
          y1: 372.4,
          x2: 366.4,
          y2: 665.4,
          target: "genosis",
          location: "/Genosis", // <-- new
        },
        {
          name: "Nepotis",
          x1: 480.4,
          y1: 390.4,
          x2: 781.4,
          y2: 646.4,
          target: "nepotis",
          location: "/Nepotis", // <-- new
        },
      ],
    },

    mustafar: {
      img: "../static/images/mapImages/MustafarMap.png",
      regions: [
        {
          name: "BlackFire Citadel",
          location_id: 6,
          x1: 132.4,
          y1: 147.4,
          x2: 326.4,
          y2: 263.4,
          action: "travel",
          message: "Travelling to BlackFire Citadel",
          location: "/Mustafar/BlackFire%20Citadel",
        },
        {
          name: "Forge of Korran",
          location_id: 13,
          x1: 530.4,
          y1: 165.4,
          x2: 696.4,
          y2: 312.4,
          action: "travel",
          message: "Travelling to Forge of Korran",
          location: "/Mustafar/Forge%20of%20Korran",
        },
        {
          name: "Ashen Bastion",
          location_id: 7,
          x1: 538.4,
          y1: 342.4,
          x2: 706.4,
          y2: 467.4,
          action: "travel",
          message: "Travelling to Ashen Bastion",
          location: "/Mustafar/Ashen%20Bastion",
        },
        {
          name: "Vulkar Keep",
          location_id: 20,
          x1: 315.4,
          y1: 396.4,
          x2: 560.4,
          y2: 548.4,
          action: "travel",
          message: "Travelling to Vulkar Keep",
          location: "/Mustafar/Vulkar%20Keep",
        },
        {
          name: "Molten Fissure",
          location_id: 19,
          x1: 92.4,
          y1: 427.4,
          x2: 265.4,
          y2: 575.4,
          action: "travel",
          message: "Travelling to Molten Fissure",
          location: "/Mustafar/Molten%20Fissure",
        },
        {
          name: "The Scoria Pits",
          location_id: 14,
          x1: 87.4,
          y1: 291.4,
          x2: 275.4,
          y2: 433.4,
          action: "travel",
          message: "Travelling to The Scoria Pits",
          location: "/Mustafar/The%20Scoria%20Pits",
        },
      ],
    },

    kamino: {
      img: "../static/images/mapImages/KaminoMap.png",
      regions: [
        {
          name: "OnceanWatch Keep",
          location_id: 9,
          x1: 28.4,
          y1: 317.4,
          x2: 209.4,
          y2: 463.4,
          action: "travel",
          message: "Travelling to OnceanWatch Keep",
          location: "/Kamino/OceanWatch%20Keep",
        },
        {
          name: "Citadel of Echoes",
          location_id: 15,
          x1: 285.4,
          y1: 398.4,
          x2: 577.4,
          y2: 543.4,
          action: "travel",
          message: "Travelling to Citadel of Echoes",
          location: "/Kamino/Citadel%20of%20Echoes",
        },
        {
          name: "Pearl Depths",
          location_id: 21,
          x1: 314.4,
          y1: 560.4,
          x2: 473.4,
          y2: 631.4,
          action: "travel",
          message: "Travelling to Pearl Depths",
          location: "/Kamino/Pearl%20Depths",
        },
        {
          name: "The Tide Docks",
          location_id: 2,
          x1: 626.4,
          y1: 375.4,
          x2: 814.4,
          y2: 491.4,
          action: "travel",
          message: "Travelling to The Tide Docks",
          location: "/Kamino/The%20Tide%20Docks",
        },
        {
          name: "The SpireFoundry",
          location_id: 8,
          x1: 513.4,
          y1: 183.4,
          x2: 799.4,
          y2: 321.4,
          action: "travel",
          message: "Travelling to The SpireFoundry",
          location: "/Kamino/The%20SpireFoundry",
        },
        {
          name: "Tipoca City",
          location_id: 1,
          x1: 311.4,
          y1: 101.4,
          x2: 617.4,
          y2: 223.4,
          action: "travel",
          message: "Travelling to Tipoca City",
          location: "/Kamino/Tipoca%20City",
        },
      ],
    },

    genosis: {
      img: "../static/images/mapImages/GenosisMap.png",
      regions: [
        {
          name: "Riftstone Stronghold",
          location_id: 10,
          x1: 97.4,
          y1: 119.4,
          x2: 285.4,
          y2: 223.4,
          action: "travel",
          message: "Travelling to Riftstone Stronghold",
          location: "/Genosis/Riftstone%20Stronghold",
        },
        {
          name: "Scarab Expanse",
          location_id: 16,
          x1: 49.406,
          y1: 351.4,
          x2: 213.4,
          y2: 467.4,
          action: "travel",
          message: "Travelling to Scarab Expanse",
          location: "/Genosis/Scarab%20Expanse",
        },
        {
          name: "BoneCrater Hollow",
          location_id: 22,
          x1: 357.4,
          y1: 560.4,
          x2: 517.4,
          y2: 662.4,
          action: "travel",
          message: "Travelling to BoneCrater Hollow",
          location: "/Genosis/BoneCrater%20Hollow",
        },
        {
          name: "The Great Foundry",
          location_id: 17,
          x1: 615.4,
          y1: 373.4,
          x2: 799.4,
          y2: 473.4,
          action: "travel",
          message: "Travelling to The Great Foundry",
          location: "/Genosis/The%20Great%20Foundry",
        },
        {
          name: "The Dune Gate",
          location_id: 3,
          x1: 583.4,
          y1: 144.4,
          x2: 757.4,
          y2: 275.4,
          action: "travel",
          message: "Travelling to The Dune Gate",
          location: "/Genosis/The%20Dune%20Gate",
        },
      ],
    },

    nepotis: {
      img: "../static/images/mapImages/NepotisMap.png",
      regions: [
        {
          name: "Elarion",
          location_id: 4,
          x1: 313.4,
          y1: 85.4,
          x2: 505.4,
          y2: 183.4,
          action: "travel",
          message: "Travelling to Elarion",
          location: "/Nepotis/Elarion",
        },
        {
          name: "Verdant Spire",
          location_id: 11,
          x1: 606.4,
          y1: 187.4,
          x2: 752.4,
          y2: 296.4,
          action: "travel",
          message: "Travelling to Verdant Spire",
          location: "/Nepotis/Verdant%20Spire",
        },
        {
          name: "The Emerald Heart",
          location_id: 18,
          x1: 561.4,
          y1: 334.4,
          x2: 730.4,
          y2: 464.4,
          action: "travel",
          message: "Travelling to The Emerald Heart",
          location: "/Nepotis/The%20Emerald%20Heart",
        },
        {
          name: "Silverfall Reach",
          location_id: 5,
          x1: 446.4,
          y1: 475.4,
          x2: 643.4,
          y2: 584.4,
          action: "travel",
          message: "Travelling to Silverfall Reach",
          location: "/Nepotis/Silverfall%20Reach",
        },
        {
          name: "Mistwood Grove",
          location_id: 23,
          x1: 89.4,
          y1: 478.4,
          x2: 296.4,
          y2: 592.4,
          action: "travel",
          message: "Travelling to Mistwood Grove",
          location: "/Nepotis/Mistwood%20Grove",
        },
        {
          name: "Green Watch",
          location_id: 12,
          x1: 89.4,
          y1: 207.4,
          x2: 280.4,
          y2: 356.4,
          action: "travel",
          message: "Travelling to GreenWatch",
          location: "/Nepotis/GreenWatch",
        },
      ],
    },
  };

  let currentMap = "main";

  const mapImage = new Image();
  let isImageReady = false;

  function setMap(mapName) {
    currentMap = mapName;
    isImageReady = false;
    mapImage.src = maps[currentMap].img;
  }

  const backBtn = document.querySelector("#backBtn");
  backBtn.addEventListener("click", function (evt) {
    evt.preventDefault();
    window.location.href = "/map";
  });

  mapImage.onload = function () {
    isImageReady = true;
  };

  const initialMap = window.INITIAL_MAP || "main";
  setMap(initialMap);

  function map() {
    ctx.clearRect(0, 0, CANVAS_WIDTH, CANVAS_HEIGHT);

    if (isImageReady) {
      ctx.drawImage(mapImage, 0, 0, CANVAS_WIDTH, CANVAS_HEIGHT);
    }

    requestAnimationFrame(map);
  }

  requestAnimationFrame(map);

  canvas.addEventListener("click", (e) => {
    if (!isImageReady) return;

    const rect = canvas.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const y = e.clientY - rect.top;

    const regions = maps[currentMap].regions;

    for (const r of regions) {
      if (x >= r.x1 && x <= r.x2 && y >= r.y1 && y <= r.y2) {
        if (r.action === "travel") {
          console.log(r.message);
          startTransition(r.message, r.location);

          const locationId = r.location_id;
          sessionStorage.setItem("location_id", locationId);

          const saveId = localStorage.getItem("save_id");
          const name = localStorage.getItem("character_name");

          console.log("updatinglocation");
          if (!locationId || !saveId || !name) {
            console.error("Cannot update location: missing fields", {
              locationId,
              saveId,
              name,
            });
            return;
          }

          fetch("/characters/update-location", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              location_id: locationId,
              save_id: saveId,
              name: name,
            }),
          })
            .then((res) => res.json())
            .then((data) => {
              console.log("DB updated:", data);
            })
            .catch((err) => console.error("Error updating location:", err));

          return;
        }

        if (r.target) {
          setMap(r.target);
        }

        break;
      }
    }
  });

  // let start = null;

  // canvas.addEventListener("click", (e) => {
  //   const rect = canvas.getBoundingClientRect();

  //   const x = e.clientX - rect.left;
  //   const y = e.clientY - rect.top;

  //   if (!start) {
  //     start = { x, y };
  //     console.log("Start:", start);
  //   } else {
  //     const region = {
  //       name: "Empire",
  //       x1: Math.min(start.x, x),
  //       y1: Math.min(start.y, y),
  //       x2: Math.max(start.x, x),
  //       y2: Math.max(start.y, y),
  //     };

  //     console.log("Region created:", region);
  //     start = null;
  //   }
  // });
}
const transitionScreen = document.querySelector("#transitionScreen");
const transitionText = document.querySelector("#transitionText");

function startTransition(message, location) {
  transitionText.textContent = message || "Travelling...";
  transitionScreen.classList.add("active");

  sessionStorage.setItem("transition", "true");
  sessionStorage.setItem("transitionText", message || "Travelling...");

  setTimeout(() => {
    window.location.href = location;
  }, 1200);
}

const closeMap = document.querySelector("#closeMap");
// CLOSE MAP
closeMap?.addEventListener("click", (evt) => {
  evt.preventDefault();
  window.location.href = lcoation;
});
