defmodule Day1Test do
  use ExUnit.Case, async: true

  test "run" do
    assert Day1.part1() == 54601
    assert Day1.part2() == 53536
  end
end
