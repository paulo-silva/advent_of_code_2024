defmodule AdventOfCode2024.Day4 do
  @moduledoc """
  Solution of day 4
  """

  @directions [
    {-1, -1},
    {-1, 1},
    {1, -1},
    {1, 1}
  ]

  def run(input) do
    count =
      input
      |> String.split("\n")
      |> parse()
      |> count_mas()

    {:ok, count}
  end

  defp count_mas(grid) do
    Enum.reduce(grid, 0, fn {position, _}, count ->
      @directions
      |> Enum.reduce(count, fn direction, count ->
        case matches_mas?(grid, position, direction) and
               matches_mas?(grid, position, rotate90(direction)) do
          true -> count + 1
          false -> count
        end
      end)
    end)
  end

  defp matches_mas?(grid, position, direction) do
    at(grid, position) === ?A and
      at(grid, add(position, direction)) === ?M and
      at(grid, add(position, rotate180(direction))) === ?S
  end

  defp rotate90({a, b}), do: {b, -a}
  defp rotate180({a, b}), do: {-a, -b}

  defp at(grid, position) do
    case grid do
      %{^position => char} -> char
      %{} -> nil
    end
  end

  defp add({a, b}, {c, d}), do: {a + c, b + d}

  defp parse(input) do
    input
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, row} ->
      String.to_charlist(line)
      |> Enum.with_index()
      |> Enum.flat_map(fn {char, col} ->
        position = {row, col}
        [{position, char}]
      end)
    end)
    |> Map.new()
  end
end
