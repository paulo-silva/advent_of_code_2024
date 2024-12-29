defmodule AdventOfCode2024.Day10 do
  @moduledoc """
  Solution of day 10
  """

  @trailhead 0
  @trailend 9
  @directions %{
    up: {-1, 0},
    right: {0, 1},
    down: {1, 0},
    left: {0, -1}
  }
  @direction_names Map.keys(@directions)

  def run(input) do
    result =
      input
      |> parse_input()
      |> count_valid_trails()

    {:ok, result}
  end

  defp parse_input(input) do
    board =
      input
      |> String.split("\n")
      |> Enum.with_index()
      |> Enum.flat_map(fn {row, row_number} ->
        cols = row |> String.codepoints() |> Enum.map(&String.to_integer/1)

        cols
        |> Enum.with_index()
        |> Enum.map(fn {col, col_number} -> {{row_number, col_number}, col} end)
      end)
      |> Map.new()

    trailheads = board |> Map.filter(fn {_, value} -> value == @trailhead end) |> Map.keys()

    %{board: board, trailheads: trailheads}
  end

  defp count_valid_trails(%{board: board, trailheads: trailheads}) do
    trailheads
    |> Task.async_stream(
      fn trailhead ->
        trailhead
        |> count_paths(board, @trailhead + 1, [])
        |> List.flatten()
        |> Enum.chunk_by(&(&1 == "|"))
        |> Enum.reject(&(&1 == ["|"]))
        |> Enum.uniq_by(fn [{@trailend, position} | _] -> position end)
        |> length()
      end,
      ordered: false
    )
    |> Enum.reduce(0, fn {:ok, value}, acc -> value + acc end)
  end

  defp count_paths(_, _, value, acc) when value > @trailend, do: ["|" | acc]

  defp count_paths(current_position, board, expected_value, acc) do
    for direction_name <- @direction_names do
      new_position = move(current_position, direction_name)
      new_position_value = Map.get(board, new_position)

      if expected_value == new_position_value do
        count_paths(new_position, board, expected_value + 1, [
          {new_position_value, new_position} | acc
        ])
      else
        []
      end
    end
  end

  defp move({row_number, col_number}, direction_name) do
    {row_number_add, col_number_add} = Map.fetch!(@directions, direction_name)
    {row_number + row_number_add, col_number + col_number_add}
  end
end
