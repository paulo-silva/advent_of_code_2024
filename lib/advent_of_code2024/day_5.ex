defmodule AdventOfCode2024.Day5 do
  @moduledoc """
  Solution of day 5
  """

  def run(input) do
    result =
      input
      |> parse_input()
      |> filter_correct_pages()
      |> Enum.map(&get_middle_value/1)
      |> Enum.sum()

    {:ok, result}
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.reduce({%{}, []}, fn
      "", acc ->
        acc

      line, {rules, pages_to_produce} ->
        if String.contains?(line, "|") do
          [first_value, second_value] =
            line |> String.split("|") |> Enum.map(&String.to_integer/1)

          {Map.update(rules, first_value, [second_value], &[second_value | &1]), pages_to_produce}
        else
          page_to_produce = line |> String.split(",") |> Enum.map(&String.to_integer/1)
          {rules, [page_to_produce | pages_to_produce]}
        end
    end)
    |> then(fn {rules, pages_to_produce} ->
      {rules, Enum.reverse(pages_to_produce)}
    end)
  end

  defp filter_correct_pages({rules, pages_to_produce}) do
    Enum.filter(pages_to_produce, &valid_page?(&1, rules))
  end

  defp valid_page?(page_to_produce, rules) do
    page_to_produce
    |> Enum.with_index()
    |> Enum.reduce_while(true, fn
      {_, 0}, true ->
        {:cont, true}

      {value, index}, true ->
        previous_index = index - 1
        valid_values = page_to_produce |> Enum.at(previous_index) |> then(&Map.get(rules, &1, []))

        if value in valid_values do
          {:cont, true}
        else
          {:halt, false}
        end
    end)
  end

  defp get_middle_value(page_to_produce) do
    total_indexes = length(page_to_produce) - 1
    middle_index = div(total_indexes, 2)

    Enum.at(page_to_produce, middle_index)
  end
end
