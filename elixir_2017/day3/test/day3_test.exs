defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  test "calc ring number" do
    assert Day3.ring(1)[:num] == 1
    assert Day3.ring(2)[:num] == 2
    assert Day3.ring(3)[:num] == 2
    assert Day3.ring(9)[:num] == 2
    assert Day3.ring(10)[:num] == 3
    assert Day3.ring(17)[:num] == 3
    assert Day3.ring(25)[:num] == 3
  end

  test "calc square position" do
    assert Day3.position(1)  == {0, 0}
    assert Day3.position(2)  == {1, 0}
    assert Day3.position(10) == {2,-1}
    assert Day3.position(26) == {3,-2}

    assert Day3.position(3)  == {1, 1}
    assert Day3.position(4)  == {0, 1}
    assert Day3.position(5)  == {-1, 1}
    assert Day3.position(6)  == {-1, 0}
    assert Day3.position(7)  == {-1, -1}
    assert Day3.position(8)  == {0, -1}
    assert Day3.position(9)  == {1, -1}
  end

  test "part1" do
    assert Day3.part1(1) == 0
    assert Day3.part1(12) == 3
    assert Day3.part1(347991) == 480
  end

  test "value" do
    assert Day3.value(1) == 1
    assert Day3.value(2) == 1
    assert Day3.value(3) == 2
    assert Day3.value(4) == 4
    assert Day3.value(5) == 5
  end

  test "part2" do
    assert Day3.part2(26) == 54
    assert Day3.part2(347991) == 349975
  end
end
