defmodule AdventOfCode2024.Day100Test do
  use ExUnit.Case
  doctest AdventOfCode2024.Day10

  alias AdventOfCode2024.Day10

  describe "run/1" do
    test "calculates the distance" do
      input =
        Enum.join(
          [
            "89010123",
            "78121874",
            "87430965",
            "96549874",
            "45678903",
            "32019012",
            "01329801",
            "10456732"
          ],
          "\n"
        )

      assert Day10.run(input) == {:ok, 81}
    end
  end
end
