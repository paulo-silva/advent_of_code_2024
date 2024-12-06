defmodule AdventOfCode2024.Day4Test do
  use ExUnit.Case
  doctest AdventOfCode2024.Day4

  alias AdventOfCode2024.Day4

  describe "run/1" do
    test "counts how many reports are safe" do
      input =
        Enum.join(
          [
            "MMMSXXMASM",
            "MSAMXMSMSA",
            "AMXSXMAAMM",
            "MSAMASMSMX",
            "XMASAMXAMM",
            "XXAMMXXAMA",
            "SMSMSASXSS",
            "SAXAMASAAA",
            "MAMMMXMMMM",
            "MXMXAXMASX"
          ],
          "\n"
        )

      assert Day4.run(input) == {:ok, 18}
    end
  end
end
