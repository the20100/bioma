/**
 * Resizable hook - handles mouse/touch drag to resize panels.
 */
const Resizable = {
  mounted() {
    const container = this.el;
    const direction = container.dataset.direction || "horizontal";
    const isHorizontal = direction === "horizontal";
    const handles = container.querySelectorAll("[data-handle]");

    handles.forEach((handle) => {
      handle.dataset.direction = direction;

      let isDragging = false;
      let startPos = 0;
      let prevPanel = null;
      let nextPanel = null;
      let containerSize = 0;
      let prevInitial = 0;
      let nextInitial = 0;

      const onMouseDown = (e) => {
        e.preventDefault();
        isDragging = true;

        prevPanel = handle.previousElementSibling;
        nextPanel = handle.nextElementSibling;

        if (!prevPanel || !nextPanel) return;

        containerSize = isHorizontal
          ? container.offsetWidth
          : container.offsetHeight;
        startPos = isHorizontal ? e.clientX : e.clientY;
        prevInitial = isHorizontal
          ? prevPanel.offsetWidth
          : prevPanel.offsetHeight;
        nextInitial = isHorizontal
          ? nextPanel.offsetWidth
          : nextPanel.offsetHeight;

        document.addEventListener("mousemove", onMouseMove);
        document.addEventListener("mouseup", onMouseUp);
        document.body.style.cursor = isHorizontal
          ? "col-resize"
          : "row-resize";
        document.body.style.userSelect = "none";
      };

      const onMouseMove = (e) => {
        if (!isDragging || !prevPanel || !nextPanel) return;

        const delta = (isHorizontal ? e.clientX : e.clientY) - startPos;
        const prevMin =
          parseFloat(prevPanel.dataset.minSize || 10) * 0.01 * containerSize;
        const prevMax =
          parseFloat(prevPanel.dataset.maxSize || 90) * 0.01 * containerSize;
        const nextMin =
          parseFloat(nextPanel.dataset.minSize || 10) * 0.01 * containerSize;
        const nextMax =
          parseFloat(nextPanel.dataset.maxSize || 90) * 0.01 * containerSize;

        let newPrev = prevInitial + delta;
        let newNext = nextInitial - delta;

        // Enforce constraints
        newPrev = Math.max(prevMin, Math.min(prevMax, newPrev));
        newNext = Math.max(nextMin, Math.min(nextMax, newNext));

        const prevPct = (newPrev / containerSize) * 100;
        const nextPct = (newNext / containerSize) * 100;

        prevPanel.style.flexBasis = `${prevPct}%`;
        nextPanel.style.flexBasis = `${nextPct}%`;
      };

      const onMouseUp = () => {
        isDragging = false;
        document.removeEventListener("mousemove", onMouseMove);
        document.removeEventListener("mouseup", onMouseUp);
        document.body.style.cursor = "";
        document.body.style.userSelect = "";
      };

      handle.addEventListener("mousedown", onMouseDown);

      // Touch support
      handle.addEventListener("touchstart", (e) => {
        const touch = e.touches[0];
        onMouseDown({
          preventDefault: () => {},
          clientX: touch.clientX,
          clientY: touch.clientY,
        });

        const onTouchMove = (e) => {
          const touch = e.touches[0];
          onMouseMove({ clientX: touch.clientX, clientY: touch.clientY });
        };

        const onTouchEnd = () => {
          onMouseUp();
          document.removeEventListener("touchmove", onTouchMove);
          document.removeEventListener("touchend", onTouchEnd);
        };

        document.addEventListener("touchmove", onTouchMove);
        document.addEventListener("touchend", onTouchEnd);
      });
    });
  },
};

export default Resizable;
