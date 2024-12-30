defmodule AdventOfCode2024.Day11 do
  @moduledoc """
  Solution of day 11
  """

  @default_number_of_blinks 75
  @cache_table :stones_cache

  def run(input, blinkings \\ @default_number_of_blinks) do
    init_cache()

    result =
      input
      |> parse_input()
      |> Enum.map(&count_stones(&1, blinkings))
      |> Enum.sum()

    {:ok, result}
  end

  defp init_cache do
    if :ets.whereis(@cache_table) != :undefined do
      :ets.delete(@cache_table)
    end

    :ets.new(@cache_table, [:set, :public, :named_table])
  end

  defp parse_input(input) do
    input
    |> String.split(~r/\s+/)
    |> Enum.map(&String.to_integer/1)
  end

  defp count_stones(stone, blinkings) when is_integer(blinkings) do
    cache_key = {stone, blinkings}

    case :ets.lookup(@cache_table, cache_key) do
      [{_key, result}] ->
        result

      [] ->
        stone
        |> calculate_stones(blinkings)
        |> tap(&:ets.insert(@cache_table, {cache_key, &1}))
    end
  end

  defp calculate_stones({_first, _second}, 0), do: 2
  defp calculate_stones(_stone, 0), do: 1

  defp calculate_stones(stone, depth) do
    case blink_stone(stone) do
      {first, second} ->
        count_stones(first, depth - 1) + count_stones(second, depth - 1)

      stone ->
        count_stones(stone, depth - 1)
    end
  end

  defp blink_stone(0), do: 1

  defp blink_stone(stone) do
    digits = Integer.digits(stone)
    number_of_digits = length(digits)

    if even?(number_of_digits) do
      middle = div(number_of_digits, 2)
      first = digits |> Enum.take(middle) |> Integer.undigits()
      second = digits |> Enum.drop(middle) |> Integer.undigits()
      {first, second}
    else
      2024 * stone
    end
  end

  defp even?(value), do: rem(value, 2) == 0
end
