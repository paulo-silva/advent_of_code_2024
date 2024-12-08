defmodule AdventOfCode2024.Day8Test do
  use ExUnit.Case
  doctest AdventOfCode2024.Day8

  alias AdventOfCode2024.Day8

  describe "run/1" do
    test "counts how many reports are safe" do
      input =
        Enum.join(
          [
            "............",
            "........0...",
            ".....0......",
            ".......0....",
            "....0.......",
            "......A.....",
            "............",
            "............",
            "........A...",
            ".........A..",
            "............",
            "............"
          ],
          "\n"
        )

      assert Day8.run(input) == {:ok, 14}
    end
  end
end
