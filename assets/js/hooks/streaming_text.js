/**
 * StreamingText hook - handles progressive text rendering.
 * Listens for stream_delta and stream_complete events from the server.
 */
const StreamingText = {
  mounted() {
    this.handleEvent("stream_delta", ({ delta }) => {
      this.el.textContent += delta;
      this.el.dataset.streaming = "true";
    });

    this.handleEvent("stream_replace", ({ content }) => {
      this.el.textContent = content;
    });

    this.handleEvent("stream_complete", () => {
      this.el.dataset.streaming = "false";
    });
  },
};

export default StreamingText;
