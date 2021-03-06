defmodule LiveViewTodoWeb.TodoAppLive do
  use Phoenix.LiveView

  alias LiveViewTodo.Todo

  def render(assigns) do
    Phoenix.View.render(LiveViewTodoWeb.MainView, "index.html", assigns)
  end

  @spec mount(map, Phoenix.LiveView.Socket.t()) :: {:ok, Phoenix.LiveView.Socket.t()}
  def mount(_params, socket) do
    {:ok, assign(socket, todos: [], filter: "all")}
  end

  @spec handle_params(map, binary, Phoenix.LiveView.Socket.t()) ::
          {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_params(%{"filter" => filter}, _uri, socket) do
    {:noreply, assign(socket, filter: filter)}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  @spec handle_event(binary, map, Phoenix.LiveView.Socket.t()) ::
          {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_event("add-todo", %{"text" => text}, socket) do
    todos = socket.assigns[:todos] ++ [Todo.new(text)]

    {:noreply, assign(socket, todos: todos)}
  end

  def handle_event("toggle", %{"todo-id" => id}, socket) do
    toggle = fn
      %Todo{id: ^id} = todo -> Todo.toggle(todo)
      todo -> todo
    end

    todos = socket.assigns[:todos] |> Enum.map(toggle)

    {:noreply, assign(socket, todos: todos)}
  end

  def handle_event("toggle-all", %{"toggle-all" => "on"}, socket) do
    todos = socket.assigns[:todos] |> Enum.map(&Todo.complete/1)

    {:noreply, assign(socket, todos: todos)}
  end

  def handle_event("toggle-all", _params, socket) do
    todos = socket.assigns[:todos] |> Enum.map(&Todo.activate/1)

    {:noreply, assign(socket, todos: todos)}
  end

  def handle_event("destroy", %{"todo-id" => id}, socket) do
    todos = socket.assigns[:todos] |> Enum.reject(fn t -> t.id == id end)

    {:noreply, assign(socket, todos: todos)}
  end

  def handle_event("clear-completed", _params, socket) do
    todos = socket.assigns[:todos] |> Enum.reject(fn t -> t.state == "completed" end)

    {:noreply, assign(socket, todos: todos)}
  end

  def handle_event("edit", %{"todo-id" => id}, socket) do
    toggle_editing = fn
      %Todo{id: ^id} = todo -> %{todo | editing: true}
      todo -> todo
    end

    todos = socket.assigns[:todos] |> Enum.map(toggle_editing)

    {:noreply, assign(socket, todos: todos)}
  end

  def handle_event("change", %{"title" => text}, socket) do
    update_text = fn
      %Todo{editing: true} = todo -> %{todo | text: text}
      todo -> todo
    end

    todos = socket.assigns[:todos] |> Enum.map(update_text)

    {:noreply, assign(socket, todos: todos)}
  end

  def handle_event("submit-change", %{"title" => text}, socket) do
    update_text = fn
      %Todo{editing: true} = todo -> %{todo | text: text}
      todo -> todo
    end

    todos = socket.assigns[:todos] |> Enum.map(update_text)

    {:noreply, assign(socket, todos: todos)}
  end

  def handle_event("stop-editing", %{"todo-id" => id}, socket) do
    toggle_editing = fn
      %Todo{id: ^id} = todo -> %{todo | editing: false}
      todo -> todo
    end

    todos = socket.assigns[:todos] |> Enum.map(toggle_editing)

    {:noreply, assign(socket, todos: todos)}
  end
end
