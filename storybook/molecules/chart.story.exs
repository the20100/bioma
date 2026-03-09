defmodule Storybook.Molecules.Chart do
  use PhoenixStorybook.Story, :component

  def function, do: &Bioma.Molecules.Chart.chart/1

  def variations do
    [
      %Variation{
        id: :bar,
        description: "Bar chart",
        attributes: %{
          id: "demo-bar-chart",
          type: "bar",
          data: [
            %{label: "Jan", value: 186},
            %{label: "Feb", value: 305},
            %{label: "Mar", value: 237},
            %{label: "Apr", value: 73},
            %{label: "May", value: 209},
            %{label: "Jun", value: 214}
          ]
        }
      },
      %Variation{
        id: :line,
        description: "Line chart",
        attributes: %{
          id: "demo-line-chart",
          type: "line",
          data: [
            %{label: "Jan", value: 186},
            %{label: "Feb", value: 305},
            %{label: "Mar", value: 237},
            %{label: "Apr", value: 73},
            %{label: "May", value: 209},
            %{label: "Jun", value: 214}
          ]
        }
      },
      %Variation{
        id: :pie,
        description: "Pie chart",
        attributes: %{
          id: "demo-pie-chart",
          type: "pie",
          data: [
            %{label: "Chrome", value: 275},
            %{label: "Safari", value: 200},
            %{label: "Firefox", value: 187},
            %{label: "Edge", value: 173},
            %{label: "Other", value: 90}
          ]
        }
      }
    ]
  end
end
