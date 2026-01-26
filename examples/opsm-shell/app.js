const modeSelect = document.getElementById("mode");

modeSelect.addEventListener("change", (event) => {
  document.body.setAttribute("data-mode", event.target.value);
});
