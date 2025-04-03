/** @param {HTMLButtonElement} node */
function openDropdown(node) {
  if (node.parentElement.classList.contains("open")) {
    node.parentElement.classList.remove("open");
  } else {
    node.parentElement.classList.add("open");
  }
}

const DROPDOWNS = document.querySelectorAll(".w-dropdown");

window.addEventListener(
  "click",
  /** @param {PointerEvent} event */
  function (event) {
    DROPDOWNS.forEach((dropdown) => {
      if (!dropdown.contains(event.target)) {
        dropdown.classList.remove("open");
      }
    });
  },
);

/** @param {HTMLButtonElement} node */
function showHelp(node) {
  alert(node.dataset.help);
}

/** @param {HTMLButtonElement} node */
function switchTab(node) {
  const container = node.parentElement.parentElement;
  const currentTab = container.dataset.tab;
  const newTab = node.id.split("-")[1];
  container.dataset.tab = newTab;

  // Yes, this is shitcode. Sue me.
  try {
    container.querySelector(`#tab-${currentTab}`).dataset.selected = "false";
  } catch (error) { }
  try {
    container
      .querySelector(`#page-${currentTab}`)
      .style.setProperty("display", "none");
  } catch (error) { }

  try {
    container.querySelector(`#tab-${newTab}`).dataset.selected = "true";
  } catch (error) { }
  try {
    container.querySelector(`#page-${newTab}`).style.removeProperty("display");
  } catch (error) { }

  node.blur();
}

/** @param {HTMLElement} container */
function SetTabView(container, newTab) {
  container
    .querySelector(`#page-${container.dataset.tab}`)
    .style.setProperty("display", "none");

  container.querySelector(`#page-${newTab}`).style.removeProperty("display");
  container.dataset.tab = newTab;
}

const THEMES = {
  dark: {
    default: `
      theme-shade: #000000;
      theme-background: #121212;
      theme-card: rgba(255,255,255,0.06);
      theme-hover: rgba(255,255,255,0.12);
      theme-inactive: rgba(255,255,255,0.33);
      theme-border: #424242;
      theme-cavity: rgba(0,0,0,0.25);
      theme-foreground: #ffffff;

      palette-accent: #1b48c4;
      palette-accent-text: #1faeff;
      palette-secondary: #b000bf;
      palette-secondary-text: #b000bf;
      palette-warning: #da9d00;
      palette-warning-text: #da9d00;
      palette-success: #008f48;
      palette-success-text: #008f48;
      palette-disturbing: #c41b48;
      palette-disturbing-text: #ff4f4f;
    `,
    high_contrast: `
      theme-shade: #000000;
      theme-background: #181818;
      theme-card: rgba(255,255,255,0.12);
      theme-hover: rgba(255,255,255,0.24);
      theme-inactive: rgba(255,255,255,0.6);
      theme-border: #939393;
      theme-cavity: rgba(0,0,0,0.5);
      theme-foreground: #ffffff;

      palette-accent: #1b48c4;
      palette-accent-text: #1faeff;
      palette-secondary: #b000bf;
      palette-secondary-text: #b000bf;
      palette-warning: #da9d00;
      palette-warning-text: #da9d00;
      palette-success: #008f48;
      palette-success-text: #008f48;
      palette-disturbing: #c41b48;
      palette-disturbing-text: #ff4f4f;
    `,
  },
  light: {
    default: `
      theme-shade: #CFCFCF;
      theme-background: #ffffff;
      theme-card: rgba(0,0,0,0.08);
      theme-hover: rgba(0,0,0,0.16);
      theme-inactive: rgba(0,0,0,0.33);
      theme-border: #9A9A9A;
      theme-cavity: rgba(255,255,255,0.25);
      theme-foreground: #000000;

      palette-accent: #1b48c4;
      palette-accent-text: #1faeff;
      palette-secondary: #b000bf;
      palette-secondary-text: #b000bf;
      palette-warning: #da9d00;
      palette-warning-text: #da9d00;
      palette-success: #008f48;
      palette-success-text: #008f48;
      palette-disturbing: #c41b48;
      palette-disturbing-text: #ff4f4f;
    `,
    sand: `
      theme-shade: #d5c39f;
      theme-background: #fbf0c5;
      theme-card: rgba(60, 56, 53, 0.12);
      theme-hover: rgba(60, 56, 53,0.24);
      theme-inactive: rgba(60, 56, 53,0.4);
      theme-border: #928373;
      theme-cavity: rgba(255,255,255,0.25);
      theme-foreground: #3c3835;

      palette-accent: #1b48c4;
      palette-accent-text: #1faeff;
      palette-secondary: #b000bf;
      palette-secondary-text: #b000bf;
      palette-warning: #da9d00;
      palette-warning-text: #da9d00;
      palette-success: #008f48;
      palette-success-text: #008f48;
      palette-disturbing: #c41b48;
      palette-disturbing-text: #ff4f4f;
    `,
  },
};

/** @param {HTMLInputElement} node */
function setTheme(node) {
  if (!node.checked) {
    return;
  }

  const theme = String(THEMES[node.dataset.mode][node.dataset.theme]);
  if (theme === "undefined") {
    return;
  }

  const str = theme.replaceAll("\n", "").replaceAll(" ", "");
  for (const value of str.split(";")) {
    if (!value) {
      continue;
    }

    const parts = value.split(":");
    document.body.style.setProperty(`--${parts[0]}`, parts[1]);
  }
}

const MIN_VIEWPORT = 16 * 74
const containers = document.querySelectorAll(".js-adapt-tabs-on-mobile");
let toggled = false;

function refreshSidebar(event) {
  let viewportWidth = Math.max(document.documentElement.clientWidth || 0, window.innerWidth || 0)

  if (viewportWidth < MIN_VIEWPORT && !toggled) {
    toggled = true;

    containers.forEach(container => {
      const sidebar = container.querySelector("aside");
      const tabContainer = container.querySelector(".c-tabs");

      container.removeChild(sidebar);
      tabContainer.appendChild(sidebar);
      sidebar.style.setProperty("display", "none");
    });
  } else if (viewportWidth >= MIN_VIEWPORT && toggled) {
    toggled = false;

    containers.forEach(container => {
      const sidebar = container.querySelector("aside");
      const tabContainer = container.querySelector(".c-tabs");
      tabContainer.removeChild(sidebar);
      container.appendChild(sidebar);
      sidebar.style.removeProperty("display");

      if (tabContainer.dataset.tab == "sidebar") {
        switchTab(tabContainer.querySelector(`[data-fallback="true"]`))
      }
    });
  }
}

window.addEventListener("resize", event => refreshSidebar(event), true);
refreshSidebar(null);
