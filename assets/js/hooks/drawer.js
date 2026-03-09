/**
 * Drawer hook - handles touch drag-to-dismiss gestures.
 */
const Drawer = {
  mounted() {
    const overlay = this.el;
    const panel = overlay.querySelector("[role=dialog]");
    const direction = overlay.dataset.direction || "bottom";

    if (!panel) return;

    let startY = 0;
    let startX = 0;
    let currentTranslate = 0;
    let isDragging = false;

    const isVertical = direction === "bottom" || direction === "top";
    const dismissThreshold = 100;

    panel.addEventListener("touchstart", (e) => {
      startY = e.touches[0].clientY;
      startX = e.touches[0].clientX;
      isDragging = true;
      panel.style.transition = "none";
    });

    panel.addEventListener("touchmove", (e) => {
      if (!isDragging) return;

      const deltaY = e.touches[0].clientY - startY;
      const deltaX = e.touches[0].clientX - startX;

      if (isVertical) {
        const translate = direction === "bottom" ? Math.max(0, deltaY) : Math.min(0, deltaY);
        currentTranslate = translate;
        panel.style.transform = `translateY(${translate}px)`;
      } else {
        const translate = direction === "right" ? Math.max(0, deltaX) : Math.min(0, deltaX);
        currentTranslate = translate;
        panel.style.transform = `translateX(${translate}px)`;
      }
    });

    panel.addEventListener("touchend", () => {
      isDragging = false;
      panel.style.transition = "transform 0.3s ease";

      if (Math.abs(currentTranslate) > dismissThreshold) {
        // Dismiss
        const full = isVertical ? panel.offsetHeight : panel.offsetWidth;
        const sign = direction === "bottom" || direction === "right" ? 1 : -1;
        const prop = isVertical ? "translateY" : "translateX";
        panel.style.transform = `${prop}(${sign * full}px)`;
        setTimeout(() => {
          overlay.hidden = true;
          panel.style.transform = "";
          panel.style.transition = "";
        }, 300);
      } else {
        // Snap back
        panel.style.transform = isVertical ? "translateY(0)" : "translateX(0)";
      }
      currentTranslate = 0;
    });
  },
};

export default Drawer;
