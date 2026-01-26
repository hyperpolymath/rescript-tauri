const modeSelect = document.getElementById("mode");
const input = document.querySelector(".input");
const planPanel = document.querySelector(".plan");
const planButton = document.querySelector(".panel-footer button");

function setMode(value) {
  document.body.setAttribute("data-mode", value);
  modeSelect.value = value;
}

function parsePlan(text) {
  const backends = new Set([
    "rpm-ostree",
    "toolbox",
    "distrobox",
    "container",
    "native",
    "git",
    "source",
    "auto",
  ]);

  const tokens = text
    .split(/\s+/)
    .map((t) => t.trim())
    .filter(Boolean)
    .map((t) => t.replace(/^\[/, "").replace(/\]$/, ""));

  let current = "auto";
  const plan = {};

  tokens.forEach((token) => {
    const parts = token.split(":");
    if (parts.length > 1) {
      const backend = parts[0].toLowerCase();
      const rest = parts.slice(1).join(":").trim();
      if (rest.length === 0) {
        current = backends.has(backend) ? backend : "auto";
        return;
      }
      const resolved = backends.has(backend) ? backend : "auto";
      plan[resolved] = plan[resolved] || [];
      plan[resolved].push(rest);
      current = resolved;
    } else {
      const target = current || "auto";
      plan[target] = plan[target] || [];
      plan[target].push(token);
    }
  });

  return plan;
}

function renderPlan(plan) {
  planPanel.innerHTML = "";
  const entries = Object.entries(plan);
  if (entries.length === 0) {
    planPanel.innerHTML = "<div>No items parsed.</div>";
    return;
  }
  entries.forEach(([backend, pkgs]) => {
    const row = document.createElement("div");
    row.innerHTML = `<strong>${backend}:</strong> ${pkgs.join(", ")}`;
    planPanel.appendChild(row);
  });
}

modeSelect.addEventListener("change", (event) => {
  setMode(event.target.value);
});

planButton.addEventListener("click", () => {
  const text = input.value || "";
  const plan = parsePlan(text);
  renderPlan(plan);
});

// Optional Tauri menu integration
if (window.__TAURI__ && window.__TAURI__.event) {
  window.__TAURI__.event.listen("opsm:mode", (event) => {
    if (event && event.payload) {
      setMode(event.payload);
    }
  });

  window.__TAURI__.event.listen("opsm:dry-run", () => {
    if (input) {
      input.focus();
    }
  });
}
