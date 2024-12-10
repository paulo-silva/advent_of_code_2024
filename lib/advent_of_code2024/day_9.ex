defmodule AdventOfCode2024.Day9 do
  @moduledoc """
  Solution of day 9
  """

  def run(input) do
    result =
      input
      |> parse_input()
      |> find_blocks()
      |> move_blocks()
      |> calculate_checksum()

    {:ok, result}
  end

  defp parse_input(input) do
    input
    |> String.codepoints()
    |> Enum.map(&String.to_integer/1)
  end

  defp find_blocks(input, blocks \\ [], phase \\ :capture_id, current_id \\ nil)

  defp find_blocks([value | tail], blocks, phase, current_id) do
    {updated_block, new_phase, new_id} = append_block(value, blocks, phase, current_id)

    find_blocks(tail, updated_block, new_phase, new_id)
  end

  defp find_blocks([], blocks, _, _), do: Enum.reverse(blocks)

  defp append_block(value, blocks, :capture_id, nil),
    do: append_block(value, blocks, :capture_id, 0)

  defp append_block(value, blocks, :capture_id, id) do
    new_blocks = for _i <- 1..value, do: id
    updated_block = Enum.reduce(new_blocks, blocks, &[&1 | &2])

    {updated_block, :empty_spaces, id + 1}
  end

  defp append_block(0, blocks, :empty_spaces, id) do
    {blocks, :capture_id, id}
  end

  defp append_block(value, blocks, :empty_spaces, id) do
    new_blocks = for _i <- 1..value, do: "."
    updated_block = Enum.reduce(new_blocks, blocks, &[&1 | &2])

    {updated_block, :capture_id, id}
  end

  defp move_blocks(blocks) do
    total_numbers = Enum.count(blocks, &is_integer/1)

    move_blocks(blocks, Enum.reverse(blocks), [], total_numbers)
  end

  defp move_blocks(_, _, new_block, total_numbers) when total_numbers <= 0,
    do: Enum.reverse(new_block)

  defp move_blocks(
         ["." | tail_block] = blocks,
         [value | tail_reverse_block],
         new_block,
         total_numbers
       ) do
    case value do
      "." ->
        move_blocks(blocks, tail_reverse_block, new_block, total_numbers)

      int_value ->
        move_blocks(tail_block, tail_reverse_block, [int_value | new_block], total_numbers - 1)
    end
  end

  defp move_blocks([value | tail_block], ["." | tail_reverse_block], new_block, total_numbers) do
    move_blocks(tail_block, tail_reverse_block, [value | new_block], total_numbers - 1)
  end

  defp move_blocks([value | tail_block], reverse_block, new_block, total_numbers) do
    move_blocks(tail_block, reverse_block, [value | new_block], total_numbers - 1)
  end

  defp calculate_checksum(blocks) do
    blocks
    |> Enum.with_index()
    |> Enum.reduce(0, fn {value, id}, acc -> value * id + acc end)
  end
end
