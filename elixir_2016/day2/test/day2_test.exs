defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "moves to new key" do
    valid = &(true or &1)
    assert Day2.move_key({0, 0}, :down, valid) == {0, 1}
    assert Day2.move_key({0, 0}, :right, valid) == {1, 0}
    assert Day2.move_key({1, 1}, :up, valid) == {1, 0}
    assert Day2.move_key({1, 1}, :left, valid) == {0, 1}
  end

  test "does not move to new key if on edge of pad" do
    valid = &(false and &1)
    assert Day2.move_key({0, 0}, :up, valid) == {0, 0}
    assert Day2.move_key({0, 0}, :left, valid) == {0, 0}
    assert Day2.move_key({0, 2}, :down, valid) == {0, 2}
    assert Day2.move_key({2, 0}, :right, valid) == {2, 0}
  end

  test "do series of key moves" do
    assert Day2.move_keys({0, 0}, [:down, :right], &(true or &1)) == {1, 1}
  end

  test "convert position to number" do
    assert Day2.pos_to_key1({0,0}) == "1"
    assert Day2.pos_to_key1({1,0}) == "2"
    assert Day2.pos_to_key1({2,0}) == "3"
    assert Day2.pos_to_key1({2,1}) == "6"
    assert Day2.pos_to_key1({0,1}) == "4"
    assert Day2.pos_to_key1({1,2}) == "8"
  end

  test "parse input into moves" do
    assert Day2.parse_input("UDLR\nDU\n") == [[:up, :down, :left, :right], [:down, :up]]
  end

  test "calculate code from moves" do
    keypad = {{0, 0}, &Day2.is_valid_pos1/1, &Day2.pos_to_key1/1}
    assert Day2.calculate_code([[:up, :down, :left, :right], [:down, :up]], keypad) == "55"
  end

  test "part1" do
    assert Day2.part1() == "56855"
  end

  ## Part 2 ##

  test "part2" do
    assert Day2.part2() == "B3C27"
  end

  test "position to number 2" do 
    assert Day2.pos_to_key2({-1, 0}) == "6"
    assert Day2.pos_to_key2({0, 0}) == "7"
    assert Day2.pos_to_key2({1, 0}) == "8"
    assert Day2.pos_to_key2({2, 0}) == "9"
    assert Day2.pos_to_key2({0, -1}) == "3"
    assert Day2.pos_to_key2({1, -1}) == "4"
    assert Day2.pos_to_key2({0, -2}) == "1"
    assert Day2.pos_to_key2({0, 1}) == "B"
    assert Day2.pos_to_key2({0, 2}) == "D"
  end
end
