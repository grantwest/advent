defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "largest difference" do
    assert Day2.largest_difference([]) == 0
    assert Day2.largest_difference([1]) == 0
    assert Day2.largest_difference([1, 1]) == 0
    assert Day2.largest_difference([5, 1, 9, 5]) == 8
  end

  test "part1" do
    assert Day2.part1() == {:ok, 53460}
  end

  test "whole quotient" do
    assert Day2.whole_quotient([5, 9, 2, 8]) == 4
  end

  test "part2" do
    assert Day2.part2() == {:ok, 282}
  end
end
