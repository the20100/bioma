defmodule Bioma.Atoms.Typography do
  @moduledoc """
  Typography components for consistent text styling.

  Provides a set of semantic typography components following shadcn/ui conventions.

  ## Examples

      <.h1>Main Heading</.h1>
      <.h2>Section Heading</.h2>
      <.p>Body text paragraph.</.p>
      <.lead>A lead paragraph with larger text.</.lead>
      <.muted>Some muted helper text.</.muted>
      <.prose>Rich content with prose styling.</.prose>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :class, :string, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def h1(assigns) do
    ~H"""
    <h1
      class={
        cn([
          "scroll-m-20 text-4xl font-extrabold tracking-tight lg:text-5xl",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </h1>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def h2(assigns) do
    ~H"""
    <h2
      class={
        cn([
          "scroll-m-20 border-b pb-2 text-3xl font-semibold tracking-tight",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </h2>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def h3(assigns) do
    ~H"""
    <h3
      class={
        cn([
          "scroll-m-20 text-2xl font-semibold tracking-tight",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </h3>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def h4(assigns) do
    ~H"""
    <h4
      class={
        cn([
          "scroll-m-20 text-xl font-semibold tracking-tight",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </h4>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def p(assigns) do
    ~H"""
    <p
      class={
        cn([
          "leading-7 [&:not(:first-child)]:mt-6",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </p>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def lead(assigns) do
    ~H"""
    <p
      class={
        cn([
          "text-xl text-muted-foreground",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </p>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def large(assigns) do
    ~H"""
    <div
      class={
        cn([
          "text-lg font-semibold",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def small(assigns) do
    ~H"""
    <small
      class={
        cn([
          "text-sm font-medium leading-none",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </small>
    """
  end

  attr :class, :string, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def muted(assigns) do
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

  attr :class, :string, default: nil
  attr :rest, :global

  slot :inner_block, required: true

  def prose(assigns) do
    ~H"""
    <div
      class={
        cn([
          "prose prose-sm dark:prose-invert max-w-none",
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
