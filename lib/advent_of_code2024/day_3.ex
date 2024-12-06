defmodule AdventOfCode2024.Day3 do
  @moduledoc """
  Solution of day 3
  """

  def run(input) do
    result =
      input
      |> reject_disabled_data()
      |> parse_input()
      |> sum_multis(0)

    {:ok, result}
  end

  defp reject_disabled_data(input) do
    input
    |> String.split(~r/do\(\)|don't\(\)/, include_captures: true)
    |> reject_disabled_data(true)
  end

  defp reject_disabled_data(captures, enabled?, acc \\ "")

  defp reject_disabled_data(["don't()" | rest], true, acc) do
    reject_disabled_data(rest, false, acc)
  end

  defp reject_disabled_data(["do()" | rest], false, acc) do
    reject_disabled_data(rest, true, acc)
  end

  defp reject_disabled_data([enabled_data | rest], true, acc) do
    reject_disabled_data(rest, true, acc <> enabled_data)
  end

  defp reject_disabled_data([_ignore | rest], false, acc) do
    reject_disabled_data(rest, false, acc)
  end

  defp reject_disabled_data([], _, acc), do: acc

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
