defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  test "is valid shape" do
    assert Day3.is_valid([2,2,2]) == true 
    assert Day3.is_valid([2,2,8]) == false 
  end

  test "can parse input" do
    assert Day3.parse_input("  338  274  638\n  346  188  656\n") == [[338, 274, 638], [346, 188, 656]]
  end

  test "part1" do
    assert Day3.part1() == {:ok, 983}
  end

  ## Part 2 ##
  test "transpose" do
    assert Day3.transpose([[1, 2], [3, 4]]) == [[1, 3], [2, 4]]
  end

  test "part2" do
    assert Day3.part2() == {:ok, 1836}
  end
end
