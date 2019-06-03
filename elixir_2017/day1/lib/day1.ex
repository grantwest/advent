defmodule Day1 do

  def part1() do
    File.open("input.txt", [:read, :utf8], fn(f) ->
      IO.read(f, :all)
      |> String.trim()
      |> String.codepoints()
      |> Enum.map(&String.to_integer/1)
      |> sum_consequtive()
    end)
  end

  def sum_consequtive([]), do: 0
  def sum_consequtive([head | tail] = numbers) do
    next_numbers = tail ++ [head]
    Enum.zip(numbers, next_numbers)
    |> Enum.filter(fn({v1, v2}) -> v1 == v2 end)
    |> Enum.reduce(0, fn({v1, _}, sum) -> v1 + sum end)
  end

# Part 2 ##############################################

  def part2() do
    File.open("input.txt", [:read, :utf8], fn(f) ->
      IO.read(f, :all)
      |> String.trim()
      |> String.codepoints()
      |> Enum.map(&String.to_integer/1)
      |> sum_consequtive2()
    end)
  end

  def sum_consequtive2(numbers) do
    half = div length(numbers), 2
    match_numbers = Stream.concat(Stream.drop(numbers, half), Stream.take(numbers, half))
    Stream.zip(numbers, match_numbers)
    |> Stream.filter(fn({v1, v2}) -> v1 == v2 end)
    |> Enum.reduce(0, fn({v1, _}, sum) -> v1 + sum end)
  end

end
