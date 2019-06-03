defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "sum consequtive" do
    assert Day1.sum_consequtive([]) == 0
    assert Day1.sum_consequtive([1, 2]) == 0
    assert Day1.sum_consequtive([1]) == 1
    assert Day1.sum_consequtive([1, 1, 2]) == 1
    assert Day1.sum_consequtive([1, 1, 2, 1]) == 2
  end

  test "part 1" do
    assert Day1.part1() == {:ok, 1228}
  end

  test "sum consequtive2" do
    assert Day1.sum_consequtive2([1, 2, 1, 2]) == 6
    assert Day1.sum_consequtive2([1, 2, 2, 1]) == 0
    assert Day1.sum_consequtive2([1, 2, 2, 1]) == 0
    assert Day1.sum_consequtive2([1, 2, 3, 4, 2, 5]) == 4
    assert Day1.sum_consequtive2([1, 2, 3, 1, 2, 3]) == 12
  end

  test "part 2" do
    assert Day1.part2() == {:ok, 1238}
  end
end
