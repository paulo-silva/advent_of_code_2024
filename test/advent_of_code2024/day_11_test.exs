defmodule AdventOfCode2024.Day11Test do
  use ExUnit.Case
  doctest AdventOfCode2024.Day11
  alias AdventOfCode2024.Day11

  describe "run/1" do
    test "has 22 stones after blinking six times" do
      input = "125 17"
      assert Day11.run(input, 6) == {:ok, 22}
    end
  end
end
