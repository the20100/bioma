/**
 * MarkdownEditor hook
 *
 * Wires up the markdown editor toolbar and mode switcher.
 *
 * Listens for two custom events dispatched via `JS.dispatch`:
 *   - `md-editor:action`      – { action: string } → insert/wrap markdown syntax
 *   - `md-editor:switch-mode` – { mode: "edit"|"preview"|"split" } → show/hide panes
 *
 * Also intercepts the Tab key in the textarea and inserts two spaces instead
 * of moving focus.
 */
const MarkdownEditor = {
  mounted() {
    this.textarea = this.el.querySelector("textarea");

    this.el.addEventListener("md-editor:action", (e) => {
      this.handleAction(e.detail.action);
    });

    this.el.addEventListener("md-editor:switch-mode", (e) => {
      this.switchMode(e.detail.mode);
    });

    if (this.textarea) {
      this.textarea.addEventListener("keydown", (e) => {
        if (e.key === "Tab") {
          e.preventDefault();
          this.insertAtCursor("  ");
        }
      });
    }

    // Apply initial mode from data attribute
    this.switchMode(this.el.dataset.mode || "edit");
  },

  // ---------------------------------------------------------------------------
  // Toolbar action dispatch
  // ---------------------------------------------------------------------------

  handleAction(action) {
    const map = {
      bold: { wrap: "**", placeholder: "bold text" },
      italic: { wrap: "_", placeholder: "italic text" },
      strikethrough: { wrap: "~~", placeholder: "strikethrough" },
      code: { wrap: "`", placeholder: "code" },
      code_block: { block: "```\ncode here\n```" },
      link: { template: "[link text](https://)" },
      quote: { prefix: "> " },
      ul: { prefix: "- " },
      ol: { prefix: "1. " },
      heading: { prefix: "## " },
    };

    const cfg = map[action];
    if (!cfg) return;

    if (cfg.wrap) this.wrapSelection(cfg.wrap, cfg.placeholder);
    else if (cfg.block) this.insertBlock(cfg.block);
    else if (cfg.template) this.insertAtCursor(cfg.template);
    else if (cfg.prefix) this.prefixLine(cfg.prefix);
  },

  // ---------------------------------------------------------------------------
  // Text manipulation helpers
  // ---------------------------------------------------------------------------

  wrapSelection(wrap, placeholder) {
    const ta = this.textarea;
    if (!ta) return;

    const start = ta.selectionStart;
    const end = ta.selectionEnd;
    const selected = ta.value.substring(start, end) || placeholder;
    const replacement = `${wrap}${selected}${wrap}`;

    this.replaceRange(start, end, replacement);

    // If placeholder was used, select it so the user can immediately overtype
    if (!ta.value.substring(start, end)) {
      ta.setSelectionRange(start + wrap.length, start + wrap.length + placeholder.length);
    }
  },

  insertBlock(text) {
    const ta = this.textarea;
    if (!ta) return;

    const start = ta.selectionStart;
    const before = ta.value.substring(0, start);
    const after = ta.value.substring(start);
    const prefix = before.length > 0 && !before.endsWith("\n") ? "\n\n" : "";

    ta.value = before + prefix + text + "\n\n" + after;

    const pos = start + prefix.length + text.length + 2;
    ta.setSelectionRange(pos, pos);
    ta.dispatchEvent(new Event("input", { bubbles: true }));
    ta.focus();
  },

  prefixLine(prefix) {
    const ta = this.textarea;
    if (!ta) return;

    const start = ta.selectionStart;
    const lineStart = ta.value.lastIndexOf("\n", start - 1) + 1;
    this.replaceRange(lineStart, lineStart, prefix);
  },

  replaceRange(start, end, text) {
    const ta = this.textarea;
    if (!ta) return;

    const before = ta.value.substring(0, start);
    const after = ta.value.substring(end);
    ta.value = before + text + after;

    const newPos = start + text.length;
    ta.setSelectionRange(newPos, newPos);
    ta.dispatchEvent(new Event("input", { bubbles: true }));
    ta.focus();
  },

  insertAtCursor(text) {
    const ta = this.textarea;
    if (!ta) return;
    this.replaceRange(ta.selectionStart, ta.selectionEnd, text);
  },

  // ---------------------------------------------------------------------------
  // Mode switching
  // ---------------------------------------------------------------------------

  switchMode(mode) {
    const editPane = this.el.querySelector("[id$='-edit-pane']");
    const previewPane = this.el.querySelector("[id$='-preview-pane']");
    const modeBtns = this.el.querySelectorAll("[data-mode-btn]");

    if (!editPane || !previewPane) return;

    const showEdit = mode !== "preview";
    const showPreview = mode !== "edit";

    editPane.classList.toggle("hidden", !showEdit);
    previewPane.classList.toggle("hidden", !showPreview);

    modeBtns.forEach((btn) => {
      const active = btn.dataset.modeBtn === mode;
      btn.classList.toggle("bg-background", active);
      btn.classList.toggle("font-medium", active);
    });

    this.el.dataset.mode = mode;
  },
};

export default MarkdownEditor;
