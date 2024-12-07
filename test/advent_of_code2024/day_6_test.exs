defmodule AdventOfCode2024.Day6Test do
  use ExUnit.Case
  doctest AdventOfCode2024.Day6

  alias AdventOfCode2024.Day6

  describe "run/1" do
    test "counts how many reports are safe" do
      input =
        Enum.join(
          [
            "....#.....",
            ".........#",
            "..........",
            "..#.......",
            ".......#..",
            "..........",
            ".#..^.....",
            "........#.",
            "#.........",
            "......#..."
          ],
          "\n"
        )

      assert Day6.run(input) == {:ok, 41}
    end
  end
end
