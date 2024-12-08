defmodule AdventOfCode2024.Day7 do
  @moduledoc """
  Solution of day 7
  """

  def run(input) do
    result =
      input
      |> parse_input()
      |> Task.async_stream(
        fn {result, values} -> if match_result?(result, values), do: result, else: 0 end,
        ordered: false
      )
      |> Enum.reduce(0, fn {:ok, result}, acc -> acc + result end)

    {:ok, result}
  end

  def concat(number_1, number_2), do: String.to_integer("#{number_1}#{number_2}")

  defp operators, do: [&Kernel.+/2, &Kernel.*/2, &concat/2]

  defp parse_input(input), do: input |> String.split("\n") |> Enum.map(&parse_line/1)

  defp parse_line(line) do
    [result, numbers_as_string] = String.split(line, ": ")
    numbers = numbers_as_string |> String.split(" ") |> Enum.map(&String.to_integer/1)

    {String.to_integer(result), numbers}
  end

  defp match_result?(result, [acc]), do: result == acc

  defp match_result?(result, [value_1, value_2 | tail]) do
    operators()
    |> Enum.map(&match_result?(result, [&1.(value_1, value_2) | tail]))
    |> Enum.any?()
  end
end
