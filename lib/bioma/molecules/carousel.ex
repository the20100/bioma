defmodule Bioma.Molecules.Carousel do
  @moduledoc """
  A carousel component.

  Provides a horizontal or vertical sliding content area with previous/next
  navigation and optional dot indicators. Uses scroll-snap CSS and a JS hook
  for controls.

  ## Examples

      <.carousel id="my-carousel">
        <.carousel_content target="my-carousel">
          <.carousel_item>Slide 1</.carousel_item>
          <.carousel_item>Slide 2</.carousel_item>
          <.carousel_item>Slide 3</.carousel_item>
        </.carousel_content>
        <.carousel_previous target="my-carousel" />
        <.carousel_next target="my-carousel" />
      </.carousel>

  With dot indicators:

      <.carousel id="my-carousel">
        <.carousel_content target="my-carousel">
          <.carousel_item :for={i <- 1..3}>Slide {i}</.carousel_item>
        </.carousel_content>
        <.carousel_previous target="my-carousel" />
        <.carousel_next target="my-carousel" />
        <.carousel_indicators target="my-carousel" count={3} />
      </.carousel>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  # ---------------------------------------------------------------------------
  # carousel/1
  # ---------------------------------------------------------------------------

  attr :id, :string, required: true, doc: "Unique identifier for the carousel."

  attr :orientation, :string,
    default: "horizontal",
    values: ~w(horizontal vertical),
    doc: "The scroll direction."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The carousel content, previous and next buttons."

  @doc "Renders a carousel container."
  def carousel(assigns) do
    ~H"""
    <div
      id={@id}
      phx-hook="Carousel"
      data-orientation={@orientation}
      role="region"
      aria-roledescription="carousel"
      class={cn(["relative", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # carousel_content/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the parent carousel."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The carousel items."

  @doc "Renders the scrollable content area."
  def carousel_content(assigns) do
    ~H"""
    <div
      id={"#{@target}-viewport"}
      class={
        cn([
          "flex overflow-x-auto snap-x snap-mandatory scroll-smooth",
          "[scrollbar-width:none] [&::-webkit-scrollbar]:hidden",
          "-ml-4",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # carousel_item/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The item content."

  @doc "Renders a single carousel slide."
  def carousel_item(assigns) do
    ~H"""
    <div
      role="group"
      aria-roledescription="slide"
      class={cn(["min-w-0 shrink-0 grow-0 basis-full snap-center pl-4", @class])}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  # ---------------------------------------------------------------------------
  # carousel_previous/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the parent carousel."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  @doc "Renders the previous slide button."
  def carousel_previous(assigns) do
    ~H"""
    <button
      type="button"
      id={"#{@target}-prev"}
      aria-label="Previous slide"
      class={
        cn([
          "absolute left-[-12px] top-1/2 -translate-y-1/2 z-10",
          "inline-flex items-center justify-center rounded-full border bg-background shadow-sm",
          "h-8 w-8 hover:bg-accent hover:text-accent-foreground",
          "disabled:pointer-events-none disabled:opacity-50",
          "transition-opacity",
          @class
        ])
      }
      {@rest}
    >
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width="24"
        height="24"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
        class="h-4 w-4"
      >
        <path d="m15 18-6-6 6-6" />
      </svg>
    </button>
    """
  end

  # ---------------------------------------------------------------------------
  # carousel_next/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the parent carousel."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  @doc "Renders the next slide button."
  def carousel_next(assigns) do
    ~H"""
    <button
      type="button"
      id={"#{@target}-next"}
      aria-label="Next slide"
      class={
        cn([
          "absolute right-[-12px] top-1/2 -translate-y-1/2 z-10",
          "inline-flex items-center justify-center rounded-full border bg-background shadow-sm",
          "h-8 w-8 hover:bg-accent hover:text-accent-foreground",
          "disabled:pointer-events-none disabled:opacity-50",
          "transition-opacity",
          @class
        ])
      }
      {@rest}
    >
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width="24"
        height="24"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
        class="h-4 w-4"
      >
        <path d="m9 18 6-6-6-6" />
      </svg>
    </button>
    """
  end

  # ---------------------------------------------------------------------------
  # carousel_indicators/1
  # ---------------------------------------------------------------------------

  attr :target, :string, required: true, doc: "The id of the parent carousel."
  attr :count, :integer, required: true, doc: "The total number of slides."
  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  @doc "Renders dot indicators below the carousel."
  def carousel_indicators(assigns) do
    ~H"""
    <div
      id={"#{@target}-indicators"}
      class={cn(["flex justify-center gap-1.5 pt-3", @class])}
      {@rest}
    >
      <button
        :for={i <- 0..(@count - 1)}
        type="button"
        aria-label={"Go to slide #{i + 1}"}
        data-slide-index={i}
        class={
          cn([
            "h-2 rounded-full transition-all duration-300",
            if(i == 0,
              do: "w-5 bg-primary",
              else: "w-2 bg-primary/25"
            )
          ])
        }
      />
    </div>
    """
  end
end
