defmodule AdventOfCode2024.Day3Test do
  use ExUnit.Case
  doctest AdventOfCode2024.Day3

  alias AdventOfCode2024.Day3

  describe "run/1" do
    test "counts how many reports are safe" do
      input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
      assert Day3.run(input) == {:ok, 48}
    end
  end
end
