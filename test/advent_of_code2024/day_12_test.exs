defmodule AdventOfCode2024.Day12Test do
  use ExUnit.Case
  doctest AdventOfCode2024.Day12
  alias AdventOfCode2024.Day12

  describe "run/1" do
    test "calculates the price of fencing for all regions on the map" do
      input =
        Enum.join(
          [
            "RRRRIICCFF",
            "RRRRIICCCF",
            "VVRRRCCFFF",
            "VVRCCCJFFF",
            "VVVVCJJCFE",
            "VVIVCCJJEE",
            "VVIIICJJEE",
            "MIIIIIJJEE",
            "MIIISIJEEE",
            "MMMISSJEEE"
          ],
          "\n"
        )

      assert Day12.run(input) == {:ok, 1930}
    end
  end
end
