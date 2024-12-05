defmodule AdventOfCode2024.Day2 do
  @moduledoc """
  Solution of day 2
  """

  def run(input) do
    safe_count =
      input
      |> parse_input()
      |> find_safes_and_unsafes([])
      |> Enum.count(&(&1 == :safe))

    {:ok, safe_count}
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      line |> String.split(~r/\s+/) |> Enum.map(&String.to_integer/1)
    end)
  end

  defp find_safes_and_unsafes([line | rest], results) do
    result = validate_line(line)

    find_safes_and_unsafes(rest, [result | results])
  end

  defp find_safes_and_unsafes([], results), do: results

  defp validate_line(line) do
    levels =
      line
      |> Enum.with_index()
      |> Enum.reduce([], fn
        {_, 0}, levels ->
          levels

        {value, index}, levels ->
          previous_value = Enum.at(line, index - 1)
          [previous_value - value | levels]
      end)

    cond do
      Enum.all?(levels, &(&1 in [1, 2, 3])) -> :safe
      Enum.all?(levels, &(&1 in [-1, -2, -3])) -> :safe
      true -> :unsafe
    end
  end
end
