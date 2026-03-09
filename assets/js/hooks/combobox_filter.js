/**
 * ComboboxFilter Hook
 *
 * Provides client-side filtering of combobox options as the user types in the search input.
 * If `phx-change` is also present on the search input, server-side filtering still fires.
 *
 * Attach to the combobox wrapper: <.combobox phx-hook="ComboboxFilter" ...>
 */
const ComboboxFilter = {
  mounted() {
    this._setup();
  },

  updated() {
    this._setup();
  },

  _setup() {
    const id = this.el.id;
    const searchInput = this.el.querySelector(`#${id}-search`);
    const optionsList = this.el.querySelector(`#${id}-options`);
    const emptyState = this.el.querySelector(`#${id}-empty`);
    const display = this.el.querySelector(`#${id}-display`);
    const hiddenInput = this.el.querySelector(`#${id}-input`);

    if (!searchInput || !optionsList) return;

    // Avoid duplicate listeners
    if (searchInput._comboboxFilterListener) {
      searchInput.removeEventListener("input", searchInput._comboboxFilterListener);
    }

    const filterListener = () => {
      const query = searchInput.value.toLowerCase().trim();
      let visibleCount = 0;

      optionsList.querySelectorAll("[data-combobox-option]").forEach((option) => {
        const label = option.dataset.label?.toLowerCase() || "";
        const matches = !query || label.includes(query);
        option.style.display = matches ? "" : "none";
        if (matches) visibleCount++;
      });

      if (emptyState) {
        emptyState.style.display = visibleCount === 0 ? "" : "none";
      }
    };

    searchInput._comboboxFilterListener = filterListener;
    searchInput.addEventListener("input", filterListener);

    // Update display text on selection
    if (hiddenInput && display) {
      if (hiddenInput._comboboxSelectListener) {
        hiddenInput.removeEventListener("change", hiddenInput._comboboxSelectListener);
      }
      const selectListener = (e) => {
        const value = e.detail?.value || hiddenInput.getAttribute("value") || hiddenInput.value;
        if (!value) return;
        requestAnimationFrame(() => {
          const option = optionsList.querySelector(`[data-value="${value}"]`);
          if (option) {
            // Use the original-case label from option text (strip checkmark span text)
            const labelText = option.dataset.label;
            // Find the display label from the option element's text node
            const textNode = Array.from(option.childNodes).find(
              (n) => n.nodeType === Node.TEXT_NODE && n.textContent.trim()
            );
            const displayLabel = textNode
              ? textNode.textContent.trim()
              : option.textContent.replace(/\s+/g, " ").trim();
            display.textContent = displayLabel;
            display.classList.remove("text-muted-foreground");
          }
        });
      };
      hiddenInput._comboboxSelectListener = selectListener;
      hiddenInput.addEventListener("change", selectListener);
    }

    // Reset filter when dropdown opens
    const trigger = this.el.querySelector(`[role="combobox"]`);
    if (trigger) {
      if (trigger._comboboxOpenListener) {
        trigger.removeEventListener("click", trigger._comboboxOpenListener);
      }
      const resetListener = () => {
        searchInput.value = "";
        filterListener();
        // Focus search on open
        requestAnimationFrame(() => searchInput.focus());
      };
      trigger._comboboxOpenListener = resetListener;
      trigger.addEventListener("click", resetListener);
    }
  },
};

export default ComboboxFilter;
