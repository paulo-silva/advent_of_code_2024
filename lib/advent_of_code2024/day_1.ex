defmodule AdventOfCode2024.Day1 do
  @moduledoc """
  Solution of day 1
  """

  def run(input) do
    result =
      input
      |> parse_input()
      |> find_distances()
      |> Enum.sum()

    {:ok, result}
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.reduce(%{left: [], right: []}, fn line, acc ->
      [left, right] = String.split(line, ~r/\s+/)

      %{
        acc
        | left: [String.to_integer(left) | acc.left],
          right: [String.to_integer(right) | acc.right]
      }
    end)
    |> Map.update!(:left, &Enum.sort/1)
    |> Map.update!(:right, &Enum.sort/1)
  end

  defp find_distances(parsed_input) do
    find_distances(parsed_input, [])
  end

  defp find_distances(
         %{left: [minor_left_value | left_rest]} = parsed_input,
         distances
       ) do
    count = Enum.count(parsed_input.right, &(&1 == minor_left_value))
    updated_distances = [minor_left_value * count | distances]

    find_distances(%{parsed_input | left: left_rest}, updated_distances)
  end

  defp find_distances(%{left: []}, distances), do: distances
end
