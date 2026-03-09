/**
 * CopyToClipboard hook - copies text content to clipboard.
 * Reads from data-code attribute or finds a <code> sibling.
 */
const CopyToClipboard = {
  mounted() {
    this.el.addEventListener("click", () => {
      const code =
        this.el.dataset.code ||
        this.el.closest("[data-code-block]")?.querySelector("code")
          ?.textContent ||
        "";

      navigator.clipboard.writeText(code).then(() => {
        const originalText = this.el.textContent;
        this.el.textContent = "Copied!";
        setTimeout(() => {
          this.el.textContent = originalText;
        }, 2000);
      });
    });
  },
};

export default CopyToClipboard;
