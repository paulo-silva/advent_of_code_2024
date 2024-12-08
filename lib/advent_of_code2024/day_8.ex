defmodule AdventOfCode2024.Day8 do
  @moduledoc """
  Solution of day 8
  """

  @grid_size 49

  def run(input) do
    result =
      input
      |> parse()
      |> find_antinodes(&antinodes/2)
      |> Enum.count()

    {:ok, result}
  end

  def parse(puzzle) do
    for {line, y} <- puzzle |> String.split("\n") |> Enum.with_index(), reduce: %{} do
      acc ->
        for {c, x} <- line |> String.graphemes() |> Enum.with_index(), c != ".", reduce: acc do
          acc -> Map.update(acc, c, [{x, y}], fn pos -> [{x, y} | pos] end)
        end
    end
  end

  def find_antinodes(g, fun) do
    for {_, pos} <- g, a1 <- pos, a2 <- pos, a1 != a2, n <- fun.(a1, a2), reduce: MapSet.new() do
      nodes -> MapSet.put(nodes, n)
    end
  end

  defp antinodes({x1, y1}, {x2, y2}) do
    dx = abs(x1 - x2)
    dy = abs(y1 - y2)

    Enum.filter(
      [
        {if(x1 > x2, do: x1 + dx, else: x1 - dx), if(y1 > y2, do: y1 + dy, else: y1 - dy)},
        {if(x2 > x1, do: x2 + dx, else: x2 - dx), if(y2 > y1, do: y2 + dy, else: y2 - dy)}
      ],
      fn {x, y} -> x in 0..@grid_size and y in 0..@grid_size end
    )
  end
end
