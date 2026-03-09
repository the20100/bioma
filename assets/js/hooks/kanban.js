/**
 * Kanban hook
 *
 * Enables drag-and-drop card movement between columns using the native
 * HTML5 Drag and Drop API — no external library required.
 *
 * Cards: any element with `[data-kanban-card]` and `[data-card-id]`
 * Columns: any element with `[data-kanban-column-body]` and `[data-column-id]`
 *
 * When a card is dropped the hook pushes a `"kanban_card_moved"` LiveView
 * event:
 *
 *   %{ "card_id" => string, "column_id" => string }
 *
 * Visual feedback:
 *   - Dragged card fades out (opacity-40)
 *   - Target column highlights with a ring and background tint
 *   - A thin placeholder bar shows where the card will land
 */
const Kanban = {
  mounted() {
    this.draggedCard = null;
    this.setupDragDrop();
  },

  // Re-wire after LiveView patches the DOM (e.g. after a card_moved event)
  updated() {
    this.setupDragDrop();
  },

  // ---------------------------------------------------------------------------
  // Setup
  // ---------------------------------------------------------------------------

  setupDragDrop() {
    this.el.querySelectorAll("[data-kanban-card]").forEach((card) => {
      // Avoid double-binding
      if (card.dataset.kanbanBound) return;
      card.dataset.kanbanBound = "1";
      this.makeCardDraggable(card);
    });

    this.el.querySelectorAll("[data-kanban-column-body]").forEach((col) => {
      if (col.dataset.kanbanBound) return;
      col.dataset.kanbanBound = "1";
      this.makeColumnDroppable(col);
    });
  },

  // ---------------------------------------------------------------------------
  // Card dragging
  // ---------------------------------------------------------------------------

  makeCardDraggable(card) {
    card.setAttribute("draggable", "true");

    card.addEventListener("dragstart", (e) => {
      this.draggedCard = card;
      e.dataTransfer.effectAllowed = "move";
      e.dataTransfer.setData("text/plain", card.id);
      // Defer class add so the browser snapshot is taken first
      requestAnimationFrame(() => {
        card.classList.add("opacity-40", "scale-[0.97]");
      });
    });

    card.addEventListener("dragend", () => {
      card.classList.remove("opacity-40", "scale-[0.97]");
      this.clearDropHighlights();
      this.removePlaceholder();
      this.draggedCard = null;
    });
  },

  // ---------------------------------------------------------------------------
  // Column drop zones
  // ---------------------------------------------------------------------------

  makeColumnDroppable(col) {
    col.addEventListener("dragover", (e) => {
      e.preventDefault();
      e.dataTransfer.dropEffect = "move";

      col.classList.add("ring-2", "ring-primary", "bg-accent/20");

      // Position placeholder at the natural insert point
      const after = this.getCardAfterCursor(col, e.clientY);
      const placeholder = this.getOrCreatePlaceholder();

      if (after == null) {
        col.appendChild(placeholder);
      } else {
        col.insertBefore(placeholder, after);
      }
    });

    col.addEventListener("dragleave", (e) => {
      // Only remove highlight if we left the column entirely
      if (!col.contains(e.relatedTarget)) {
        col.classList.remove("ring-2", "ring-primary", "bg-accent/20");
        this.removePlaceholder();
      }
    });

    col.addEventListener("drop", (e) => {
      e.preventDefault();
      this.clearDropHighlights();
      this.removePlaceholder();

      if (!this.draggedCard) return;

      const after = this.getCardAfterCursor(col, e.clientY);

      if (after == null) {
        col.appendChild(this.draggedCard);
      } else {
        col.insertBefore(this.draggedCard, after);
      }

      this.pushEvent("kanban_card_moved", {
        card_id: this.draggedCard.dataset.cardId,
        column_id: col.dataset.columnId,
      });
    });
  },

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /**
   * Returns the card element after the cursor position (y), or null if the
   * cursor is below all cards (append to end).
   */
  getCardAfterCursor(container, y) {
    const draggableCards = [
      ...container.querySelectorAll("[data-kanban-card]:not(.opacity-40)"),
    ];

    return draggableCards.reduce(
      (closest, child) => {
        const box = child.getBoundingClientRect();
        const offset = y - box.top - box.height / 2;
        if (offset < 0 && offset > closest.offset) {
          return { offset, element: child };
        }
        return closest;
      },
      { offset: Number.NEGATIVE_INFINITY }
    ).element;
  },

  getOrCreatePlaceholder() {
    let el = this.el.querySelector(".kanban-drag-placeholder");
    if (!el) {
      el = document.createElement("div");
      el.className =
        "kanban-drag-placeholder h-1 rounded-full bg-primary/50 mx-1 transition-all duration-100";
    }
    return el;
  },

  removePlaceholder() {
    this.el
      .querySelectorAll(".kanban-drag-placeholder")
      .forEach((el) => el.remove());
  },

  clearDropHighlights() {
    this.el
      .querySelectorAll("[data-kanban-column-body]")
      .forEach((col) =>
        col.classList.remove("ring-2", "ring-primary", "bg-accent/20")
      );
  },
};

export default Kanban;
