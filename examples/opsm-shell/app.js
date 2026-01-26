const modeSelect = document.getElementById("mode");

function setMode(value) {
  document.body.setAttribute("data-mode", value);
  modeSelect.value = value;
}

modeSelect.addEventListener("change", (event) => {
  setMode(event.target.value);
});

// Optional Tauri menu integration
if (window.__TAURI__ && window.__TAURI__.event) {
  window.__TAURI__.event.listen("opsm:mode", (event) => {
    if (event && event.payload) {
      setMode(event.payload);
    }
  });

  window.__TAURI__.event.listen("opsm:dry-run", () => {
    const input = document.querySelector(".input");
    if (input) {
      input.focus();
    }
  });
}
