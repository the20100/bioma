defmodule DevWeb.ChatLive do
  use Phoenix.LiveView

  @impl true
  def mount(_params, _session, socket) do
    conversations = [
      %{id: "1", title: "Phoenix LiveView Help", subtitle: "How do I handle file uploads?", timestamp: "2m ago"},
      %{id: "2", title: "Elixir Patterns", subtitle: "Can you explain GenServer?", timestamp: "1h ago"},
      %{id: "3", title: "Tailwind CSS Tips", subtitle: "Best practices for dark mode", timestamp: "3h ago"},
      %{id: "4", title: "Database Design", subtitle: "Schema for multi-tenant app", timestamp: "Yesterday"},
      %{id: "5", title: "Deployment Guide", subtitle: "Fly.io vs Railway comparison", timestamp: "2 days ago"}
    ]

    messages = [
      %{
        id: "msg-1",
        role: "system",
        content: "You are a helpful coding assistant specializing in Elixir and Phoenix."
      },
      %{
        id: "msg-2",
        role: "user",
        content: "How do I handle file uploads in Phoenix LiveView?",
        name: "You",
        timestamp: "2:30 PM"
      },
      %{
        id: "msg-3",
        role: "assistant",
        content: "Phoenix LiveView provides excellent built-in support for file uploads! Here's how to set it up:",
        name: "Claude",
        timestamp: "2:30 PM",
        thinking: "The user is asking about file uploads in Phoenix LiveView. I should cover allow_upload/3, the live_file_input component, handle_event for uploads, and consume_uploaded_entries. Let me give a clear step-by-step guide."
      },
      %{
        id: "msg-4",
        role: "assistant",
        content: nil,
        name: "Claude",
        tool_call: %{
          name: "search_docs",
          status: "success",
          parameters: ~s|{"query": "Phoenix LiveView file uploads", "source": "hexdocs"}|,
          result: ~s|{"results": [{"title": "Uploads", "url": "https://hexdocs.pm/phoenix_live_view/uploads.html"}]}|,
          duration_ms: 245
        }
      },
      %{
        id: "msg-5",
        role: "assistant",
        content: "First, allow uploads in your LiveView's `mount/3` callback:\n\n```elixir\ndef mount(_params, _session, socket) do\n  {:ok, allow_upload(socket, :avatar, accept: ~w(.jpg .jpeg .png), max_entries: 1)}\nend\n```\n\nThen add the upload form to your template:\n\n```heex\n<form phx-submit=\"save\" phx-change=\"validate\">\n  <.live_file_input upload={@uploads.avatar} />\n  <button type=\"submit\">Upload</button>\n</form>\n```",
        name: "Claude",
        timestamp: "2:31 PM"
      },
      %{
        id: "msg-6",
        role: "user",
        content: "That's very helpful! Can you also show me how to handle the uploaded file on the server side?",
        name: "You",
        timestamp: "2:32 PM"
      },
      %{
        id: "msg-7",
        role: "assistant",
        content: nil,
        name: "Claude",
        tool_call: %{
          name: "execute_code",
          status: "error",
          parameters: ~s|{"code": "File.read!(\"/tmp/test.ex\")"}|,
          error: "File not found: /tmp/test.ex"
        }
      },
      %{
        id: "msg-8",
        role: "assistant",
        content: "Sure! Here's how to handle the uploaded file in your `handle_event/3`:\n\n```elixir\ndef handle_event(\"save\", _params, socket) do\n  uploaded_files =\n    consume_uploaded_entries(socket, :avatar, fn %{path: path}, entry ->\n      dest = Path.join([\"priv/static/uploads\", entry.client_name])\n      File.cp!(path, dest)\n      {:ok, \"/uploads/\" <> entry.client_name}\n    end)\n\n  {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}\nend\n```\n\nThe `consume_uploaded_entries/3` function gives you access to the temporary file path and the entry metadata.",
        name: "Claude",
        timestamp: "2:32 PM"
      }
    ]

    models = [
      %{id: "claude-opus-4-6", name: "Claude Opus 4.6", description: "Most capable"},
      %{id: "claude-sonnet-4-6", name: "Claude Sonnet 4.6", description: "Fast and capable"},
      %{id: "claude-haiku-4-5", name: "Claude Haiku 4.5", description: "Fastest"}
    ]

    socket =
      socket
      |> assign(:conversations, conversations)
      |> assign(:active_conversation, "1")
      |> assign(:messages, messages)
      |> assign(:models, models)
      |> assign(:selected_model, "claude-sonnet-4-6")
      |> assign(:sending, false)
      |> assign(:streaming, false)
      |> assign(:dark_mode, true)
      |> assign(:sidebar_open, true)
      |> assign(:token_used, 2847)
      |> assign(:token_limit, 128_000)

    {:ok, socket}
  end

  @impl true
  def handle_event("send_message", %{"message" => message}, socket) when message != "" do
    user_msg = %{
      id: "msg-#{System.unique_integer([:positive])}",
      role: "user",
      content: message,
      name: "You",
      timestamp: Calendar.strftime(DateTime.utc_now(), "%-I:%M %p")
    }

    socket =
      socket
      |> update(:messages, &(&1 ++ [user_msg]))
      |> assign(:sending, true)
      |> assign(:token_used, socket.assigns.token_used + estimate_tokens(message))

    Process.send_after(self(), :simulate_response, 1500)
    {:noreply, socket}
  end

  def handle_event("send_message", _params, socket), do: {:noreply, socket}

  def handle_event("chat_input_keydown", %{"key" => "Enter", "metaKey" => true}, socket) do
    # Handled by form submit
    {:noreply, socket}
  end

  def handle_event("chat_input_keydown", _params, socket), do: {:noreply, socket}

  def handle_event("select_conversation", %{"id" => id}, socket) do
    {:noreply, assign(socket, :active_conversation, id)}
  end

  def handle_event("select_model", %{"_target" => _, "model" => model}, socket) do
    {:noreply, assign(socket, :selected_model, model)}
  end

  def handle_event("toggle_dark_mode", _params, socket) do
    {:noreply, assign(socket, :dark_mode, !socket.assigns.dark_mode)}
  end

  def handle_event("toggle_sidebar", _params, socket) do
    {:noreply, assign(socket, :sidebar_open, !socket.assigns.sidebar_open)}
  end

  def handle_event("new_chat", _params, socket) do
    {:noreply,
     socket
     |> assign(:messages, [])
     |> assign(:active_conversation, nil)
     |> assign(:token_used, 0)}
  end

  @impl true
  def handle_info(:simulate_response, socket) do
    assistant_msg = %{
      id: "msg-#{System.unique_integer([:positive])}",
      role: "assistant",
      content: "That's a great question! I'd be happy to help you with that. Let me think about the best approach...\n\nBased on the Phoenix LiveView documentation and best practices, here's what I'd recommend for your use case.",
      name: "Claude",
      timestamp: Calendar.strftime(DateTime.utc_now(), "%-I:%M %p"),
      thinking: "Let me analyze the user's question and provide a comprehensive yet concise answer."
    }

    socket =
      socket
      |> update(:messages, &(&1 ++ [assistant_msg]))
      |> assign(:sending, false)
      |> assign(:token_used, socket.assigns.token_used + 45)

    {:noreply, socket}
  end

  defp estimate_tokens(text), do: div(String.length(text), 4) + 1
end
