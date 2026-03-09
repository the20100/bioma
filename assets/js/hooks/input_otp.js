/**
 * InputOTP hook - manages focus between individual digit slots.
 */
const InputOTP = {
  mounted() {
    const container = this.el;
    const hiddenInput = container.querySelector('input[type="hidden"]');
    const slots = container.querySelectorAll('input[data-index]');
    const length = parseInt(container.dataset.length, 10);

    slots.forEach((slot, index) => {
      slot.addEventListener("input", (e) => {
        const value = e.target.value.replace(/[^0-9]/g, "");
        e.target.value = value;

        if (value && index < length - 1) {
          slots[index + 1].focus();
        }

        updateHiddenInput();
      });

      slot.addEventListener("keydown", (e) => {
        if (e.key === "Backspace" && !e.target.value && index > 0) {
          slots[index - 1].focus();
          slots[index - 1].value = "";
          updateHiddenInput();
        }
      });

      slot.addEventListener("paste", (e) => {
        e.preventDefault();
        const paste = (e.clipboardData || window.clipboardData)
          .getData("text")
          .replace(/[^0-9]/g, "")
          .slice(0, length);

        paste.split("").forEach((char, i) => {
          if (index + i < length) {
            slots[index + i].value = char;
          }
        });

        const focusIndex = Math.min(index + paste.length, length - 1);
        slots[focusIndex].focus();
        updateHiddenInput();
      });

      slot.addEventListener("focus", () => {
        slot.select();
      });
    });

    function updateHiddenInput() {
      const value = Array.from(slots)
        .map((s) => s.value)
        .join("");
      hiddenInput.value = value;

      if (value.length === length) {
        hiddenInput.dispatchEvent(new Event("change", { bubbles: true }));
      }
    }
  },
};

export default InputOTP;
