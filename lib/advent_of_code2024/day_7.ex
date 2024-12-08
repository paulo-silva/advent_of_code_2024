defmodule AdventOfCode2024.Day7 do
  @moduledoc """
  Solution of day 7
  """

  def run(input) do
    result =
      input
      |> parse_input()
      |> Enum.reduce(0, fn {result, values}, acc ->
        if match_result?(result, values), do: result + acc, else: acc
      end)

    {:ok, result}
  end

  defp parse_input(input), do: input |> String.split("\n") |> Enum.map(&parse_line/1)

  defp parse_line(line) do
    [result, numbers_as_string] = String.split(line, ": ")
    numbers = numbers_as_string |> String.split(" ") |> Enum.map(&String.to_integer/1)

    {String.to_integer(result), numbers}
  end

  @operators [&Kernel.*/2, &Kernel.+/2]
  defp match_result?(result, values, acc \\ 0)
  defp match_result?(result, [head | tail], 0), do: match_result?(result, tail, head)
  defp match_result?(same_result, _, same_result), do: true
  defp match_result?(_, [], _), do: false

  defp match_result?(result, [value | tail], acc) do
    operator_results =
      for operator <- @operators do
        match_result?(result, tail, operator.(acc, value))
      end

    Enum.any?(operator_results)
  end
end
