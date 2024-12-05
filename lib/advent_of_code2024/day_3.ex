defmodule AdventOfCode2024.Day3 do
  @moduledoc """
  Solution of day 2
  """

  def run(input) do
    result =
      input
      |> parse_input()
      |> sum_multis(0)

    {:ok, result}
  end

  @mul_regex ~r/mul\((\d+),(\d+)\)/
  defp parse_input(input) do
    Regex.scan(@mul_regex, input, capture: :all)
  end

  defp sum_multis([], acc), do: acc

  defp sum_multis([[_, number_1, number_2] | rest], acc) do
    multi = String.to_integer(number_1) * String.to_integer(number_2)
    sum_multis(rest, acc + multi)
  end
end
