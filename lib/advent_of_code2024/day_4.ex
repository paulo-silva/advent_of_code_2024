defmodule AdventOfCode2024.Day4 do
  @moduledoc """
  Solution of day 4
  """

  @directions [
    {-1, -1},
    {-1, 0},
    {-1, 1},
    {0, -1},
    {0, 1},
    {1, -1},
    {1, 0},
    {1, 1}
  ]

  def run(input) do
    count =
      input
      |> String.split("\n")
      |> parse()
      |> count_xmas()

    {:ok, count}
  end

  defp count_xmas(grid) do
    Enum.reduce(grid, 0, fn {position, _}, count ->
      @directions
      |> Enum.reduce(count, fn direction, count ->
        case matches?(grid, ~c"XMAS", position, direction) do
          true -> count + 1
          false -> count
        end
      end)
    end)
  end

  defp matches?(grid, [char | chars], position, direction) do
    case at(grid, position) do
      ^char ->
        position = add(position, direction)
        matches?(grid, chars, position, direction)

      _ ->
        false
    end
  end

  defp matches?(_, [], _, _), do: true

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
