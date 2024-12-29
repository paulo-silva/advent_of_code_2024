defmodule AdventOfCode2024.Day11 do
  @moduledoc """
  Solution of day 11
  """

  @default_number_of_blinks 25

  def run(input, blinkings \\ @default_number_of_blinks) do
    result =
      input
      |> parse_input()
      |> blink_multiple_times(blinkings)
      |> length()

    {:ok, result}
  end

  defp parse_input(input) do
    input
    |> String.split(~r/\s+/)
    |> Enum.map(&String.to_integer/1)
  end

  defp blink_multiple_times(stones, 0), do: stones

  defp blink_multiple_times(stones, remaining_blinkings) do
    stones
    |> Enum.reduce([], &update_stones/2)
    |> blink_multiple_times(remaining_blinkings - 1)
  end

  defp update_stones(0, acc), do: [1 | acc]

  defp update_stones(value, acc) do
    value_as_string = to_string(value)
    number_of_digits = String.length(value_as_string)

    if even?(number_of_digits) do
      middle = div(number_of_digits, 2)
      {left_half_digits, right_half_digits} = String.split_at(value_as_string, middle)

      [String.to_integer(left_half_digits), String.to_integer(right_half_digits) | acc]
    else
      [value * 2024 | acc]
    end
  end

  defp even?(value), do: rem(value, 2) == 0
end
