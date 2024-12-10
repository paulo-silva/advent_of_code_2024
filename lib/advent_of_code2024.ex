defmodule AdventOfCode2024 do
  @moduledoc """
  Documentation for `AdventOfCode2024`.
  """

  @spec run(non_neg_integer()) :: {:ok, any()} | {:error, any()}
  def run(day) do
    solution_module = String.to_existing_atom("Elixir.AdventOfCode2024.Day#{day}")

    day
    |> input_file()
    |> File.read!()
    |> solution_module.run()
  rescue
    error ->
      {:error, error}
  end

  def input_file(day), do: "#{File.cwd!()}/lib/advent_of_code2024/inputs/day_#{day}"
end
