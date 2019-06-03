defmodule Day6Test do
  use ExUnit.Case
  doctest Day6

  test "finds the mode" do
    assert Day6.mode(["a"]) == "a"
    assert Day6.mode(["a", "b", "c", "b"]) == "b"
  end

  test "parse input" do
    assert Day6.parse("ab\ncd") == [["a", "c"], ["b", "d"]]
  end

  test "reconstruct" do
    messages = 
      """
      eedadn
      drvtee
      eandsr
      raavrd
      atevrs
      tsrnev
      sdttsa
      rasrtv
      nssdts
      ntnada
      svetve
      tesnvt
      vntsnd
      vrdear
      dvrsen
      enarar
      """
    assert Day6.reconstruct(messages, &Day6.mode/1) == "easter"
    assert Day6.reconstruct(messages, &Day6.least_common/1) == "advent"
  end

  test "part1" do
    assert Day6.part1() == "xhnqpqql"
  end

  test "part2" do 
    assert Day6.part2() == "brhailro"
  end
end
