/**
 * ScrollBottom hook - auto-scrolls container to bottom on new content.
 * Pauses auto-scroll when user scrolls up, resumes when scrolled back to bottom.
 */
const ScrollBottom = {
  mounted() {
    this.isAtBottom = true;
    this.scrollThreshold = 50;

    this.el.addEventListener("scroll", () => {
      const { scrollHeight, scrollTop, clientHeight } = this.el;
      this.isAtBottom =
        scrollHeight - scrollTop - clientHeight < this.scrollThreshold;
    });

    this.observer = new MutationObserver(() => {
      if (this.isAtBottom) {
        requestAnimationFrame(() => {
          this.el.scrollTop = this.el.scrollHeight;
        });
      }
    });

    this.observer.observe(this.el, {
      childList: true,
      subtree: true,
      characterData: true,
    });

    // Initial scroll to bottom
    this.el.scrollTop = this.el.scrollHeight;
  },

  updated() {
    if (this.isAtBottom) {
      requestAnimationFrame(() => {
        this.el.scrollTop = this.el.scrollHeight;
      });
    }
  },

  destroyed() {
    if (this.observer) {
      this.observer.disconnect();
    }
  },
};

export default ScrollBottom;
