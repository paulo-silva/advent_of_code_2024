defmodule AdventOfCode2024.Day1Test do
  use ExUnit.Case
  doctest AdventOfCode2024.Day1

  alias AdventOfCode2024.Day1

  describe "run/1" do
    test "calculates the distance" do
      input =
        Enum.join(
          [
            "3   4",
            "4   3",
            "2   5",
            "1   3",
            "3   9",
            "3   3"
          ],
          "\n"
        )

      assert Day1.run(input) == {:ok, 11}
    end
  end
end
