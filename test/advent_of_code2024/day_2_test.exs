defmodule AdventOfCode2024.Day2Test do
  use ExUnit.Case
  doctest AdventOfCode2024.Day2

  alias AdventOfCode2024.Day2

  describe "run/1" do
    test "counts how many reports are safe" do
      input =
        Enum.join(
          [
            "7 6 4 2 1",
            "1 2 7 8 9",
            "9 7 6 2 1",
            "1 3 2 4 5",
            "8 6 4 4 1",
            "1 3 6 7 9"
          ],
          "\n"
        )

      assert Day2.run(input) == {:ok, 4}
    end
  end
end
