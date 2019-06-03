defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  test "part1" do
    # assert Day5.part1("abc") == "18f47a30"
    # assert Day5.part1("ffykfhsq") == "c6697b55"
  end

  test "generate stream of id+index" do
    assert Day5.id_index_stream("abc") |> Stream.take(2) |> Enum.to_list == ["abc0", "abc1"]
  end

  test "caluclate md5" do
    assert Day5.md5("abc3231929") == "00000155f8105dff7f56ee10fa9b9abd"
  end

  test "leading zeros" do
    assert Day5.leading_zeros("00000155f8105dff7f56ee10fa9b9abd") == 5
    assert Day5.leading_zeros("39874155f8105dff7f56ee10fa9b9abd") == 0
  end

  # test "parallelize" do
  #   result = Stream.interval(1000)
  #   |> Day5.parallelize(2, fn(enum) -> Enum.map(enum, &Integer.to_string/1) end)
  #   |> Stream.take(4) |> Enum.to_list

  #   assert result == ["0", "1", "2", "3"]
  # end

  test "part2" do
    # assert Day5.part2("abc") == "05ace8e3"
    assert Day5.part2("ffykfhsq") == "8c35d1ab"
  end

end
