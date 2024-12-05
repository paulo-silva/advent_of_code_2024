defmodule AdventOfCode2024Test do
  use ExUnit.Case
  doctest AdventOfCode2024

  alias AdventOfCode2024

  describe "run/1" do
    test "runs solution of the provided day" do
      assert {:ok, _} = AdventOfCode2024.run(1)
    end

    test "returns error when solution fail or is not found" do
      assert {:error, _} = AdventOfCode2024.run(100)
    end
  end
end
