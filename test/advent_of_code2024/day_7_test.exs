defmodule AdventOfCode2024.Day7Test do
  use ExUnit.Case
  doctest AdventOfCode2024.Day7

  alias AdventOfCode2024.Day7

  describe "run/1" do
    test "counts how many reports are safe" do
      input =
        Enum.join(
          [
            "190: 10 19",
            "3267: 81 40 27",
            "83: 17 5",
            "156: 15 6",
            "7290: 6 8 6 15",
            "161011: 16 10 13",
            "192: 17 8 14",
            "21037: 9 7 18 13",
            "292: 11 6 16 20"
          ],
          "\n"
        )

      assert Day7.run(input) == {:ok, 3749}
    end
  end
end
