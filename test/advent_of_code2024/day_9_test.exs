defmodule AdventOfCode2024.Day9Test do
  use ExUnit.Case
  doctest AdventOfCode2024.Day9

  alias AdventOfCode2024.Day9

  describe "run/1" do
    test "counts how many unique locations within the bounds of the map contain an antinode" do
      input = "2333133121414131402"

      assert Day9.run(input) == {:ok, 1928}
    end

    test "part 1 result" do
      input = 9 |> AdventOfCode2024.input_file() |> File.read!()
      assert Day9.run(input) == {:ok, 6_398_608_069_280}
    end
  end
end
