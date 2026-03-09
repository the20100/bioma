defmodule DevWeb.ThemeLive.ThemeCustomizer do
  @moduledoc false

  use Phoenix.Component

  import Bioma.Helpers, only: [cn: 1]

  attr :token_groups, :list, required: true
  attr :theme_overrides, :map, required: true
  attr :dark_mode, :boolean, default: false

  def theme_customizer(assigns) do
    ~H"""
    <div class="space-y-6 p-6 border-t bg-background">
      <div class="flex items-center justify-between">
        <h3 class="text-lg font-semibold">Customize Theme</h3>
        <span class="text-xs text-muted-foreground">
          Editing <%= if @dark_mode, do: "dark", else: "light" %> mode
        </span>
      </div>

      <div :for={{group_name, tokens} <- @token_groups} class="space-y-3">
        <h4 class="text-sm font-medium text-muted-foreground">{group_name}</h4>
        <div class="grid grid-cols-2 gap-2">
          <div :for={{token, label} <- tokens} class="space-y-1">
            <label class="text-xs text-muted-foreground">{label}</label>
            <div class="flex items-center gap-1.5">
              <span
                class="h-6 w-6 rounded border shrink-0"
                style={"background: #{token_value(@theme_overrides, @dark_mode, token)}"}
              >
              </span>
              <input
                type="text"
                value={token_value(@theme_overrides, @dark_mode, token)}
                placeholder="oklch(...)"
                phx-blur="update_token"
                phx-value-token={token}
                name="value"
                class={cn([
                  "h-7 w-full rounded-md border border-input bg-background px-2 text-xs",
                  "focus:outline-none focus:ring-1 focus:ring-ring"
                ])}
              />
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  defp token_value(overrides, dark_mode, token) do
    mode = if dark_mode, do: :dark, else: :light
    overrides |> Map.get(mode, %{}) |> Map.get(token, "")
  end
end
