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
    case parse_line_and_check_levels(line) do
      :safe -> :safe
      :unsafe -> try_removing_single_level(line)
    end
  end

  defp try_removing_single_level(line) do
    indexes = length(line) - 1

    Enum.reduce_while(0..indexes, :unsafe, fn index, _ ->
      line
      |> List.delete_at(index)
      |> parse_line_and_check_levels()
      |> case do
        :safe -> {:halt, :safe}
        :unsafe -> {:cont, :unsafe}
      end
    end)
  end

  defp parse_line_and_check_levels(line) do
    line
    |> parse_levels()
    |> check_levels()
  end

  defp check_levels(levels) do
    cond do
      Enum.all?(levels, &(&1 in [1, 2, 3])) -> :safe
      Enum.all?(levels, &(&1 in [-1, -2, -3])) -> :safe
      true -> :unsafe
    end
  end

  defp parse_levels(line) do
    line
    |> Enum.with_index()
    |> Enum.reduce([], fn
      {_, 0}, levels ->
        levels

      {value, index}, levels ->
        previous_value = Enum.at(line, index - 1)
        [previous_value - value | levels]
    end)
  end
end
