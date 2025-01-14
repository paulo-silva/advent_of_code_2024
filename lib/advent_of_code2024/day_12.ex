defmodule AdventOfCode2024.Day12 do
  @moduledoc """
  Solution of day 12
  """

  def run(input) do
    result =
      input
      |> parse_input()
      |> find_groups()

    {:ok, result}
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.reduce({%{}, nil}, fn {row, row_index}, {acc, last_position} ->
      row
      |> String.codepoints()
      |> Enum.with_index()
      |> Enum.reduce({acc, last_position}, fn {col, col_index}, {acc, _} ->
        {Map.put(acc, {row_index, col_index}, col), {row_index, col_index}}
      end)
    end)
  end

  @first_position {0, 0}
  defp find_groups(
         board_and_last_position,
         groups \\ %{},
         current_position \\ @first_position,
         current_plant \\ nil
       )

  defp find_groups({board, last_position}, groups, @first_position, nil) do
    value = Map.get(board, @first_position)

    find_groups(
      {board, last_position},
      Map.put(groups, @first_position, value),
      @first_position,
      value
    )
  end

  defp
end
