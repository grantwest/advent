defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "turning changes heading" do
    assert Day1.turn(%{heading: :north}, :right) == %{heading: :east}
    assert Day1.turn(%{heading: :north}, :left) == %{heading: :west}
    assert Day1.turn(%{heading: :west}, :right) == %{heading: :north}
    assert Day1.turn(%{heading: :west}, :left) == %{heading: :south}
  end

  test "advancing changes position" do
    assert Day1.advance(%{x: 0, y: 0, heading: :north}, 1) == %{x: 0, y: 1, heading: :north}
    assert Day1.advance(%{x: 0, y: 0, heading: :south}, 2) == %{x: 0, y: -2, heading: :south}
    assert Day1.advance(%{x: 1, y: 0, heading: :east}, 1) == %{x: 2, y: 0, heading: :east}
  end

  test "advaning one at a time creates path" do
    assert Day1.advance_one_at_a_time(%{x: 0, y: 0, heading: :north}, 0) == []
    assert Day1.advance_one_at_a_time(%{x: 0, y: 0, heading: :north}, 1) == [%{x: 0, y: 1, heading: :north}]
    assert Day1.advance_one_at_a_time(%{x: 0, y: 0, heading: :south}, 2) == [%{x: 0, y: -1, heading: :south}, %{x: 0, y: -2, heading: :south}]
  end

  test "making moves accumulates state" do
    assert Day1.accumulate_moves([[:right, 2]]) == %{x: 2, y: 0, heading: :east}
    assert Day1.accumulate_moves([[:right, 2], [:right, 2]]) == %{x: 2, y: -2, heading: :south}
  end

  test "turns moves into a path" do
    moves = [[:right, 2], [:right, 2]]
    expected_path = [
      %{x: 0, y: 0}, 
      %{x: 1, y: 0}, 
      %{x: 2, y: 0}, 
      %{x: 2, y: -1},
      %{x: 2, y: -2}
    ]
    assert Day1.moves_to_path(moves) == expected_path
  end

  test "distance is calculated for position" do
    assert Day1.distance(%{x: -4, y: 2}) == 6
  end

  test "parsing string into moves" do
    assert Day1.parse_moves("L3, R2, L2") == [[:left, 3], [:right, 2], [:left, 2]]
  end

  test "finds distance of destination" do
    assert Day1.part1("L2, R2, L2") == 6
  end

  test "finds first duplicate" do
    assert Day1.first_duplicate([1,2,3,2]) == 2
    assert Day1.first_duplicate([1,1,2,3]) == 1
    assert Day1.first_duplicate([1,2,3]) == nil
    assert Day1.first_duplicate([]) == nil
  end

  test "finds distance to first location visited twice" do
    assert Day1.part2("L2, R2, R1, R3") == 1
  end

end
