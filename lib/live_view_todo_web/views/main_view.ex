defmodule LiveViewTodoWeb.MainView do
  use LiveViewTodoWeb, :view

  @spec selected_class(binary, binary) :: nil | binary
  def selected_class(current_filter, filter) do
    if current_filter == filter do
      "selected"
    end
  end

  @spec left_count_label([LiveViewTodo.Todo.t()]) :: binary
  def left_count_label(todos) do
    ngettext(
      "1 item left",
      "%{count} items left",
      Enum.count(todos, fn t -> t.state == "active" end)
    )
  end

  @spec todo_visible?(LiveViewTodo.Todo.t(), binary) :: boolean
  def todo_visible?(_todo, "all"), do: true
  def todo_visible?(%{state: state}, state), do: true
  def todo_visible?(_, _), do: false

  def todo_classes(todo) do
    [
      if(todo.editing, do: "editing", else: ""),
      if(todo.state == "completed", do: "completed", else: "")
    ]
    |> Enum.join(" ")
  end
end
