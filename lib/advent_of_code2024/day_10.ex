defmodule AdventOfCode2024.Day10 do
  @moduledoc """
  Solution of day 10
  """

  @directions %{
    up: [-1, 0],
    right: [0, 1],
    down: [1, 0],
    left: [0, -1]
  }

  def run(input) do
    result =
      input
      |> parse_input()
      |> count_trails()

    {:ok, result}
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, line_number}, acc ->
      line
      |> String.codepoints()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {col, col_number}, acc ->
        position = {line_number, col_number}
        Map.update(acc, String.to_integer(col), [position], &[position | &1])
      end)
    end)
  end

  defp count_trails(%{0 => trailheads} = board) do
    trailheads
    |> Task.async_stream(
      fn pp2 ->
        {:ok, pid} = Agent.start_link(fn -> [] end)
        possible_trails_counter(pp2, pp2, board, 1, [{0, pp2}], pid)

        Agent.get(pid, & &1)
        |> Enum.uniq()
        |> length()
      end,
      ordered: false
    )
    |> Enum.map(fn {:ok, result} -> result end)
  end

  defp possible_trails_counter(trailhead, current_position, board, current_number, acc, pid)
  defp possible_trails_counter(_, _, _, 10, acc, pid), do: Agent.cast(pid, &[acc | &1])

  defp possible_trails_counter(trailhead, current_position, board, current_number, acc, pid) do
    for {_name, [line_add, col_add]} <- @directions do
      new_position = move(current_position, line_add, col_add)

      if new_position in Map.get(board, current_number) do
        acc = [{current_number, new_position} | acc]
        possible_trails_counter(trailhead, new_position, board, current_number + 1, acc, pid)
      else
        acc
      end
    end
  end

  defp move({line_number, col_number}, line_add, col_add) do
    {line_number + line_add, col_number + col_add}
  end
end
