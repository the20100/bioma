/**
 * TextareaAutosize hook - auto-grows textarea as user types.
 * Respects max-height if set via CSS or data-max-rows attribute.
 */
const TextareaAutosize = {
  mounted() {
    this.maxRows = parseInt(this.el.dataset.maxRows || "10", 10);
    this.resize();

    this.el.addEventListener("input", () => this.resize());

    // Handle programmatic value changes
    this.handleEvent("reset_textarea", () => {
      this.el.value = "";
      this.resize();
    });
  },

  updated() {
    this.resize();
  },

  resize() {
    this.el.style.height = "auto";
    const lineHeight = parseInt(getComputedStyle(this.el).lineHeight, 10) || 20;
    const maxHeight = lineHeight * this.maxRows;
    const newHeight = Math.min(this.el.scrollHeight, maxHeight);
    this.el.style.height = `${newHeight}px`;
    this.el.style.overflowY =
      this.el.scrollHeight > maxHeight ? "auto" : "hidden";
  },
};

export default TextareaAutosize;
