import { BiomaHooks } from "./hooks/index.js";

// Re-export hooks for Phoenix Storybook
// Storybook picks these up via the js_path configuration

(function () {
  window.storybook = {
    Hooks: BiomaHooks,
  };
})();
