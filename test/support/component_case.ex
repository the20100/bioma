defmodule Bioma.ComponentCase do
  @moduledoc """
  Shared test helpers for component rendering tests.
  """
  use ExUnit.CaseTemplate

  using do
    quote do
      import Phoenix.LiveViewTest
    end
  end
end
