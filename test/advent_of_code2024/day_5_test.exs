defmodule AdventOfCode2024.Day5Test do
  use ExUnit.Case
  doctest AdventOfCode2024.Day5

  alias AdventOfCode2024.Day5

  describe "run/1" do
    test "counts how many reports are safe" do
      input =
        Enum.join(
          [
            "47|53",
            "97|13",
            "97|61",
            "97|47",
            "75|29",
            "61|13",
            "75|53",
            "29|13",
            "97|29",
            "53|29",
            "61|53",
            "97|53",
            "61|29",
            "47|13",
            "75|47",
            "97|75",
            "47|61",
            "75|61",
            "47|29",
            "75|13",
            "53|13",
            "",
            "75,47,61,53,29",
            "97,61,53,29,13",
            "75,29,13",
            "75,97,47,61,53",
            "61,13,29",
            "97,13,75,29,47"
          ],
          "\n"
        )

      assert Day5.run(input) == {:ok, 123}
    end
  end
end
