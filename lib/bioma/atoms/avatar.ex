defmodule Bioma.Atoms.Avatar do
  @moduledoc """
  An avatar component following shadcn/ui design patterns.

  Composed of three sub-components: `avatar/1` (container), `avatar_image/1`,
  and `avatar_fallback/1`. Supports multiple sizes and graceful fallback
  when an image is unavailable.

  ## Examples

      <.avatar>
        <.avatar_image src="/images/user.jpg" alt="User" />
        <.avatar_fallback>JD</.avatar_fallback>
      </.avatar>

      <.avatar size="lg">
        <.avatar_image src={@user.avatar_url} alt={@user.name} />
        <.avatar_fallback>{String.first(@user.name)}</.avatar_fallback>
      </.avatar>

      <.avatar size="sm">
        <.avatar_fallback>AB</.avatar_fallback>
      </.avatar>
  """

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  # ── Avatar Container ──────────────────────────────────────────────────

  attr :size, :string,
    default: "default",
    values: ~w(default sm lg),
    doc: "The size of the avatar."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the avatar container."

  slot :inner_block, required: true, doc: "The avatar image and/or fallback content."

  @doc """
  Renders the avatar container element.
  """
  def avatar(assigns) do
    ~H"""
    <span
      class={
        cn([
          "relative flex shrink-0 overflow-hidden rounded-full",
          size_classes(@size),
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </span>
    """
  end

  # ── Avatar Image ──────────────────────────────────────────────────────

  attr :src, :string, required: true, doc: "The URL of the avatar image."

  attr :alt, :string, default: "", doc: "Alternative text for the avatar image."

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the image element."

  @doc """
  Renders the avatar image element.
  """
  def avatar_image(assigns) do
    ~H"""
    <img
      src={@src}
      alt={@alt}
      class={
        cn([
          "aspect-square h-full w-full",
          @class
        ])
      }
      {@rest}
    />
    """
  end

  # ── Avatar Fallback ───────────────────────────────────────────────────

  attr :class, :string, default: nil, doc: "Additional CSS classes to apply."

  attr :rest, :global, doc: "Additional HTML attributes to apply to the fallback element."

  slot :inner_block, required: true, doc: "The fallback content, typically initials."

  @doc """
  Renders the avatar fallback element, shown when no image is available.
  """
  def avatar_fallback(assigns) do
    ~H"""
    <span
      class={
        cn([
          "flex h-full w-full items-center justify-center rounded-full bg-muted",
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </span>
    """
  end

  # ── Private Helpers ───────────────────────────────────────────────────

  defp size_classes("default"), do: "h-10 w-10"
  defp size_classes("sm"), do: "h-8 w-8"
  defp size_classes("lg"), do: "h-14 w-14"
end
