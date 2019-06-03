defmodule Day4Test do
  use ExUnit.Case
  doctest Day4

  test "parse room" do
    assert Day4.parse_room("aaaaa-bbb-z-y-x-123[abxyz]\n") ==
      %{crc: "abxyz", sid: 123, name: "aaaaa-bbb-z-y-x"}
  end

  test "character counts" do
    assert Day4.character_counts("aaabbc") == MapSet.new([{"a", 3}, {"b", 2}, {"c", 1}])
  end

  test "calculate crc" do
    assert Day4.calc_crc("aaaaa-bbb-z-y-x") == "abxyz"
    assert Day4.calc_crc("not-a-real-room") == "oarel"
  end

  test "check if room is real" do
    assert Day4.is_real?(%{crc: "abxyz", name: "aaaaa-bbb-z-y-x"}) == true
    assert Day4.is_real?(%{crc: "abcde", name: "a-b-c-d-e-f-g-h"}) == true
    assert Day4.is_real?(%{crc: "oarel", name: "not-a-real-room"}) == true
    assert Day4.is_real?(%{crc: "decoy", name: "totally-real-room"}) == false
    assert Day4.is_real?(%{crc: "fakee", name: "aaaaa-bbb-z-y-x"}) == false
  end

  test "part1" do
    assert Day4.part1() == {:ok, 361724}
  end

  ## Part 2 ##

  test "decrypt character" do
    assert Day4.decrypt("-", 5) == " "
    assert Day4.decrypt("a", 0) == "a"
    assert Day4.decrypt("a", 1) == "b"
    assert Day4.decrypt("a", 2) == "c"
    assert Day4.decrypt("a", 25) == "z"
    assert Day4.decrypt("a", 26) == "a"
  end

  test "decrypt room name" do
    assert Day4.decrypt(%{name: "qzmt-zixmtkozy-ivhz", sid: 343})[:name] == "very encrypted name"
  end

  test "part2" do
    assert Day4.part2()[:sid] == 482
  end
end
