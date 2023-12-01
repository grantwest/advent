defmodule Day1 do
  def part1() do
    File.read!("../input/2023/day1.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      number_chars =
        line
        |> String.graphemes()
        |> Enum.filter(&Regex.match?(~r/[0-9]/, &1))

      {num, ""} = Integer.parse(hd(number_chars) <> List.last(number_chars))
      num
    end)
    |> Enum.sum()
  end

  def part2() do
    File.read!("../input/2023/day1.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.replace("one", "1")
      |> String.replace("two", "2")
      |> String.replace("three", "3")
      |> String.replace("four", "4")
      |> String.replace("five", "5")
      |> String.replace("six", "6")
      |> String.replace("seven", "7")
      |> String.replace("eight", "8")
      |> String.replace("nine", "9")
    end)
    |> Enum.map(fn line ->
      number_chars =
        line
        |> String.graphemes()
        |> Enum.filter(&Regex.match?(~r/[0-9]/, &1))

      {num, ""} = Integer.parse(hd(number_chars) <> List.last(number_chars))
      num
    end)
    |> Enum.sum()
  end
end
