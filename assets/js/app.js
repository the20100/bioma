import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import { BiomaHooks } from "./hooks/index.js";

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  ?.getAttribute("content");

let liveSocket = new LiveSocket("/live", Socket, {
  hooks: BiomaHooks,
  params: { _csrf_token: csrfToken },
});

liveSocket.connect();
window.liveSocket = liveSocket;
