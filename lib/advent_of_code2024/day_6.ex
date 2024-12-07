defmodule AdventOfCode2024.Day6 do
  @moduledoc """
  Solution of day 6
  """

  @obstruction "#"
  @clear_path "."
  @guard "^"

  def run(input) do
    {board, guard_position} = parse_board_and_find_guard(input)
    clear_paths = get_clear_paths(board, guard_position)
    result = count_new_obstructions(board, guard_position, clear_paths)

    {:ok, result}
  end

  defp count_new_obstructions(board, guard_position, possible_places) do
    possible_places
    |> Task.async_stream(
      fn map_key ->
        stuck_in_loop?(board, guard_position, map_key)
      end,
      timeout: 5,
      on_timeout: :kill_task,
      ordered: false
    )
    |> Enum.count(fn
      {:ok, _} -> false
      {:exit, :timeout} -> true
    end)
  end

  defp stuck_in_loop?(board, guard_position, map_key) do
    board
    |> Map.put(map_key, @obstruction)
    |> get_clear_paths(guard_position)
  end

  defp parse_board_and_find_guard(input) do
    input
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.reduce({[], nil}, fn {row, row_index}, {board, guard_position} ->
      row
      |> String.codepoints()
      |> Enum.with_index()
      |> Enum.reduce({board, guard_position}, fn
        {@guard, col_index}, {board, _} ->
          {[{{row_index, col_index}, @guard} | board], {row_index, col_index}}

        {col, col_index}, {board, guard_position} ->
          {[{{row_index, col_index}, col} | board], guard_position}
      end)
    end)
    |> then(fn {board, guard_position} ->
      {Map.new(board), guard_position}
    end)
  end

  defp get_clear_paths(board, guard_position, dir \\ :up, steps \\ MapSet.new())

  defp get_clear_paths(board, guard_position, dir, steps) do
    case move_guard(guard_position, dir, board) do
      {@obstruction, _} ->
        get_clear_paths(board, guard_position, rotate(dir), steps)

      {@clear_path, new_guard_position} ->
        get_clear_paths(board, new_guard_position, dir, MapSet.put(steps, new_guard_position))

      {@guard, new_guard_position} ->
        get_clear_paths(board, new_guard_position, dir, MapSet.put(steps, new_guard_position))

      {nil, _} ->
        steps
    end
  end

  defp move_guard({guard_row, guard_col}, dir, board) do
    {dir_row, dir_col} = direction(dir)

    map_key = {guard_row + dir_row, guard_col + dir_col}

    {Map.get(board, map_key), map_key}
  end

  defp direction(:up), do: {-1, 0}
  defp direction(:right), do: {0, 1}
  defp direction(:down), do: {1, 0}
  defp direction(:left), do: {0, -1}

  defp rotate(:up), do: :right
  defp rotate(:right), do: :down
  defp rotate(:down), do: :left
  defp rotate(:left), do: :up
end
