/**
 * ContextMenu hook - handles right-click positioning for context menus.
 */
const ContextMenu = {
  mounted() {
    const trigger = this.el.querySelector(`#${this.el.id}-trigger`);
    const content = this.el.querySelector(`#${this.el.id}-content`);

    if (!trigger || !content) return;

    trigger.addEventListener("contextmenu", (e) => {
      e.preventDefault();

      // Position the menu at the cursor
      content.style.left = `${e.clientX}px`;
      content.style.top = `${e.clientY}px`;
      content.hidden = false;
      content.style.opacity = "1";
      content.style.transform = "scale(1)";
    });
  },
};

export default ContextMenu;
