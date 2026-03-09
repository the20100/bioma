/**
 * SelectDisplay Hook
 *
 * Monitors the hidden input inside a Select component for value changes
 * (triggered by JS.dispatch("change")) and updates the visible display
 * text to match the selected item's label.
 *
 * Attach to the select wrapper: <.select id="my-select" phx-hook="SelectDisplay" ...>
 */
const SelectDisplay = {
  mounted() {
    this._setup();
  },

  updated() {
    this._setup();
  },

  _setup() {
    const selectId = this.el.id;
    const input = document.getElementById(`${selectId}-input`);
    const display = document.getElementById(`${selectId}-display`);

    if (!input || !display) return;

    // Avoid duplicate listeners
    if (input._selectListener) {
      input.removeEventListener("change", input._selectListener);
    }

    const selectEl = this.el;
    const listener = (e) => {
      // Read value from event detail (dispatched by JS.dispatch before JS.set_attribute)
      const value = e.detail?.value || input.getAttribute("value") || input.value;
      if (!value) return;

      // Use requestAnimationFrame to ensure DOM is updated after JS commands complete
      requestAnimationFrame(() => {
        const item = selectEl.querySelector(`[data-value="${value}"]`);
        if (item) {
          display.textContent = item.textContent.trim();
          display.classList.remove("text-muted-foreground");
        }
      });
    };

    input._selectListener = listener;
    input.addEventListener("change", listener);
  },
};

export default SelectDisplay;
