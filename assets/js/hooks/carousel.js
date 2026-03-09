/**
 * Carousel hook - handles prev/next navigation, dot indicators,
 * and keyboard navigation. Uses scrollTo on an overflow-x-auto
 * viewport with hidden scrollbar.
 */
const Carousel = {
  mounted() {
    this._setup();
  },

  updated() {
    this._setup();
  },

  _setup() {
    const container = this.el;
    const id = container.id;
    const viewport = document.getElementById(`${id}-viewport`);
    const prevBtn = document.getElementById(`${id}-prev`);
    const nextBtn = document.getElementById(`${id}-next`);
    const indicatorsEl = document.getElementById(`${id}-indicators`);

    if (!viewport) return;

    let currentIndex = 0;
    let isScrolling = false;

    const getSlides = () =>
      Array.from(viewport.querySelectorAll("[role=group]"));

    const scrollToSlide = (index) => {
      if (isScrolling) return;

      const slides = getSlides();
      if (!slides[index]) return;

      isScrolling = true;
      currentIndex = index;

      // Calculate target scroll position from slide offset
      const slideWidth = viewport.offsetWidth;
      const targetLeft = slideWidth * index;

      viewport.scrollTo({ left: targetLeft, behavior: "smooth" });

      updateUI();

      // Unlock after scroll animation
      setTimeout(() => {
        isScrolling = false;
      }, 450);
    };

    const detectCurrentIndex = () => {
      const slideWidth = viewport.offsetWidth;
      if (slideWidth === 0) return 0;
      const slides = getSlides();
      const index = Math.round(viewport.scrollLeft / slideWidth);
      return Math.max(0, Math.min(index, slides.length - 1));
    };

    const updateUI = () => {
      const slides = getSlides();
      const count = slides.length;
      if (count === 0) return;

      if (prevBtn) prevBtn.disabled = currentIndex === 0;
      if (nextBtn) nextBtn.disabled = currentIndex >= count - 1;

      if (indicatorsEl) {
        const dots = indicatorsEl.querySelectorAll("button");
        dots.forEach((dot, i) => {
          if (i === currentIndex) {
            dot.className =
              "h-2 rounded-full transition-all duration-300 w-5 bg-primary";
          } else {
            dot.className =
              "h-2 rounded-full transition-all duration-300 w-2 bg-primary/25";
          }
        });
      }
    };

    // Clean up previous listeners
    if (this._cleanup) this._cleanup();

    const onPrev = () => {
      if (currentIndex > 0) scrollToSlide(currentIndex - 1);
    };

    const onNext = () => {
      const slides = getSlides();
      if (currentIndex < slides.length - 1) scrollToSlide(currentIndex + 1);
    };

    const onDotClick = (e) => {
      const dot = e.target.closest("[data-slide-index]");
      if (dot) {
        const index = parseInt(dot.dataset.slideIndex, 10);
        if (index !== currentIndex) scrollToSlide(index);
      }
    };

    const onKeydown = (e) => {
      if (e.key === "ArrowLeft") {
        e.preventDefault();
        onPrev();
      } else if (e.key === "ArrowRight") {
        e.preventDefault();
        onNext();
      }
    };

    // Sync index when user manually scrolls (swipe on touch)
    let scrollTimer;
    const onScroll = () => {
      clearTimeout(scrollTimer);
      scrollTimer = setTimeout(() => {
        const detected = detectCurrentIndex();
        if (detected !== currentIndex) {
          currentIndex = detected;
          updateUI();
        }
      }, 150);
    };

    // Attach listeners
    if (prevBtn) prevBtn.addEventListener("click", onPrev);
    if (nextBtn) nextBtn.addEventListener("click", onNext);
    if (indicatorsEl) indicatorsEl.addEventListener("click", onDotClick);
    container.addEventListener("keydown", onKeydown);
    viewport.addEventListener("scroll", onScroll, { passive: true });

    this._cleanup = () => {
      if (prevBtn) prevBtn.removeEventListener("click", onPrev);
      if (nextBtn) nextBtn.removeEventListener("click", onNext);
      if (indicatorsEl)
        indicatorsEl.removeEventListener("click", onDotClick);
      container.removeEventListener("keydown", onKeydown);
      viewport.removeEventListener("scroll", onScroll);
      clearTimeout(scrollTimer);
    };

    // Initial state
    currentIndex = 0;
    updateUI();
  },

  destroyed() {
    if (this._cleanup) this._cleanup();
  },
};

export default Carousel;
