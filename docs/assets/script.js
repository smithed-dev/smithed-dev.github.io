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
