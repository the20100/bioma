defmodule DevWeb.ThemeLive do
  use Phoenix.LiveView

  alias DevWeb.ThemeLive.Presets

  @impl true
  def mount(_params, _session, socket) do
    presets = Presets.all()

    socket =
      socket
      |> assign(:preset, "default")
      |> assign(:dark_mode, false)
      |> assign(:theme_overrides, %{light: %{}, dark: %{}})
      |> assign(:radius, "0.5rem")
      |> assign(:presets, presets)
      |> assign(:token_groups, Presets.token_groups())
      |> assign(:calendar_month, Date.utc_today())
      |> assign(:calendar_selected, Date.utc_today())
      # Demo interactive state
      |> assign(:demo_plan, "free")
      |> assign(:demo_terms, false)
      |> assign(:demo_page, 1)
      |> assign(:demo_bold, true)
      |> assign(:demo_italic, false)
      |> assign(:demo_underline, false)
      |> assign(:demo_align, "left")
      |> assign(:demo_notif, %{
        "push" => true,
        "email" => true,
        "marketing" => false,
        "security" => true
      })
      # Markdown editor demo state
      |> assign(:demo_markdown, demo_markdown_initial())
      |> assign(:demo_preview_html, MDEx.to_html!(demo_markdown_initial()))

    {:ok, socket}
  end

  @impl true
  def handle_event("select_preset", %{"preset" => name}, socket) do
    case Presets.get(name) do
      nil ->
        {:noreply, socket}

      preset ->
        socket =
          socket
          |> assign(:preset, name)
          |> assign(:theme_overrides, %{light: preset.light, dark: preset.dark})

        {:noreply, socket}
    end
  end

  def handle_event("toggle_dark_mode", _params, socket) do
    {:noreply, assign(socket, :dark_mode, !socket.assigns.dark_mode)}
  end

  def handle_event("update_radius", %{"value" => value}, socket) do
    {:noreply, assign(socket, :radius, value)}
  end

  def handle_event("update_token", %{"token" => token, "value" => value}, socket) do
    mode = if socket.assigns.dark_mode, do: :dark, else: :light
    overrides = socket.assigns.theme_overrides
    mode_overrides = Map.get(overrides, mode, %{})
    updated = Map.put(mode_overrides, token, value)
    {:noreply, assign(socket, :theme_overrides, Map.put(overrides, mode, updated))}
  end

  # ── Demo interactive events ───────────────────────────────────────────

  def handle_event("demo_select_plan", %{"value" => value}, socket) do
    {:noreply, assign(socket, :demo_plan, value)}
  end

  def handle_event("demo_toggle_terms", _params, socket) do
    {:noreply, assign(socket, :demo_terms, !socket.assigns.demo_terms)}
  end

  def handle_event("demo_set_page", %{"page" => page}, socket) do
    {:noreply, assign(socket, :demo_page, String.to_integer(page))}
  end

  def handle_event("demo_toggle", %{"key" => key}, socket) do
    atom_key = String.to_existing_atom("demo_" <> key)
    {:noreply, update(socket, atom_key, &(!&1))}
  end

  def handle_event("demo_set_align", %{"align" => value}, socket) do
    {:noreply, assign(socket, :demo_align, value)}
  end

  def handle_event("demo_toggle_notif", %{"id" => id}, socket) do
    notif = socket.assigns.demo_notif
    {:noreply, assign(socket, :demo_notif, Map.update!(notif, id, &(!&1)))}
  end

  def handle_event("demo_markdown_change", %{"value" => value}, socket) do
    {:noreply,
     socket
     |> assign(:demo_markdown, value)
     |> assign(:demo_preview_html, MDEx.to_html!(value))}
  end

  # ── Calendar events ────────────────────────────────────────────────────

  def handle_event("calendar_prev_month", %{"month" => month}, socket) do
    {:noreply, assign(socket, :calendar_month, Date.from_iso8601!(month))}
  end

  def handle_event("calendar_next_month", %{"month" => month}, socket) do
    {:noreply, assign(socket, :calendar_month, Date.from_iso8601!(month))}
  end

  def handle_event("calendar_select_date", %{"date" => date}, socket) do
    {:noreply, assign(socket, :calendar_selected, Date.from_iso8601!(date))}
  end

  # ── Style helpers ──────────────────────────────────────────────────────

  @doc false
  def build_style_string(overrides, dark_mode, radius) do
    mode = if dark_mode, do: :dark, else: :light
    tokens = Map.get(overrides, mode, %{})

    radius_vars =
      if radius do
        %{
          "--radius-sm" => "calc(#{radius} - 4px)",
          "--radius-md" => "calc(#{radius} - 2px)",
          "--radius-lg" => radius,
          "--radius-xl" => "calc(#{radius} + 4px)"
        }
      else
        %{}
      end

    tokens
    |> Map.merge(radius_vars)
    |> Enum.map(fn {k, v} -> "#{k}: #{v}" end)
    |> Enum.join("; ")
  end

  @doc false
  def generate_css(overrides, radius) do
    light = Map.get(overrides, :light, %{})
    dark = Map.get(overrides, :dark, %{})

    radius_vars =
      if radius do
        %{
          "--radius-sm" => "calc(#{radius} - 4px)",
          "--radius-md" => "calc(#{radius} - 2px)",
          "--radius-lg" => radius,
          "--radius-xl" => "calc(#{radius} + 4px)"
        }
      else
        %{}
      end

    light_all = Map.merge(light, radius_vars)
    dark_all = dark

    light_css = format_css_block("@theme", light_all)
    dark_css = format_css_block(".dark", dark_all)

    String.trim("#{light_css}\n\n#{dark_css}")
  end

  defp format_css_block(_selector, tokens) when map_size(tokens) == 0, do: ""

  defp format_css_block(selector, tokens) do
    lines =
      tokens
      |> Enum.sort()
      |> Enum.map(fn {k, v} -> "  #{k}: #{v};" end)
      |> Enum.join("\n")

    "#{selector} {\n#{lines}\n}"
  end

  defp demo_markdown_initial do
    """
    # Welcome to Bioma

    A composable **Phoenix LiveView** component library for AI agentic platforms.

    ## Features

    - _Atomic design_: atoms → molecules → organisms
    - Tailwind CSS v4 with semantic color tokens
    - `Phoenix.LiveView.JS` for zero-JS interactivity

    > Edit this text and switch to **Split** or **Preview** to see live rendering.

    ```elixir
    use Bioma
    ```
    """
  end

  @doc false
  def current_token_value(overrides, dark_mode, token) do
    mode = if dark_mode, do: :dark, else: :light
    overrides |> Map.get(mode, %{}) |> Map.get(token, "")
  end
end
