defmodule Bioma.Molecules.Card do
  @moduledoc """
  A card component following shadcn/ui design patterns.

  Provides a flexible card layout with header, title, description, content, and footer
  sub-components. Uses the semantic color system for consistent theming.

  ## Examples

      <.card>
        <.card_header>
          <.card_title>Card Title</.card_title>
          <.card_description>Card description text.</.card_description>
        </.card_header>
        <.card_content>
          <p>Card body content goes here.</p>
        </.card_content>
        <.card_footer>
          <.button>Action</.button>
        </.card_footer>
      </.card>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  # ---------------------------------------------------------------------------
  # card/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The content of the card."

  @doc """
  Renders a card container with rounded borders, background, and shadow.
  """
  def card(assigns) do
    ~H"""
    <div
      class={
        cn([
          "rounded-lg border bg-card text-card-foreground shadow-sm",
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
  # card_header/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The content of the card header."

  @doc """
  Renders the header section of a card.
  """
  def card_header(assigns) do
    ~H"""
    <div
      class={
        cn([
          "flex flex-col space-y-1.5 p-6",
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
  # card_title/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The title text."

  @doc """
  Renders the title within a card header.
  """
  def card_title(assigns) do
    ~H"""
    <h3
      class={
        cn([
          "text-2xl font-semibold leading-none tracking-tight",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </h3>
    """
  end

  # ---------------------------------------------------------------------------
  # card_description/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The description text."

  @doc """
  Renders a description within a card header.
  """
  def card_description(assigns) do
    ~H"""
    <p
      class={
        cn([
          "text-sm text-muted-foreground",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </p>
    """
  end

  # ---------------------------------------------------------------------------
  # card_content/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The main content of the card."

  @doc """
  Renders the main content section of a card.
  """
  def card_content(assigns) do
    ~H"""
    <div
      class={
        cn([
          "p-6 pt-0",
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
  # card_footer/1
  # ---------------------------------------------------------------------------

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."
  attr :rest, :global, doc: "Additional HTML attributes."

  slot :inner_block, required: true, doc: "The footer content of the card."

  @doc """
  Renders the footer section of a card.
  """
  def card_footer(assigns) do
    ~H"""
    <div
      class={
        cn([
          "flex items-center p-6 pt-0",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end
end
