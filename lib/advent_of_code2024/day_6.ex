defmodule AdventOfCode2024.Day6 do
  @moduledoc """
  Solution of day 6
  """

  @obstruction "#"
  @clear_path "."
  @guard "^"

  def run(input) do
    result =
      input
      |> parse_board_and_find_guard()
      |> count_steps()

    {:ok, result}
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

  defp count_steps(board_and_guard_position, dir \\ :up, steps \\ MapSet.new())

  defp count_steps({board, guard_position}, dir, steps) do
    case move_guard(guard_position, dir, board) do
      {@obstruction, _} ->
        count_steps({board, guard_position}, rotate(dir), steps)

      {@clear_path, new_guard_position} ->
        count_steps({board, new_guard_position}, dir, MapSet.put(steps, new_guard_position))

      {@guard, new_guard_position} ->
        count_steps({board, new_guard_position}, dir, MapSet.put(steps, new_guard_position))

      {nil, _} ->
        steps |> MapSet.to_list() |> length()
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
