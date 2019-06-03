defmodule Day3 do

  def part1() do
    File.open("input.txt", [:read, :utf8], fn(f) ->
      IO.read(f, :all)
      |> parse_input
      |> Enum.count(&is_valid/1)
    end)
  end

  def parse_input(input) do
    String.split(input, "\n")
    |> Enum.map(fn(line) -> Enum.map(String.split(line, " ", trim: true), &String.to_integer/1) end)
    |> Enum.filter(&(&1 != []))
  end

  def is_valid(sides) do
    [longest | others] = sides |> Enum.sort |> Enum.reverse
    longest < Enum.sum(others)
  end

  ## Part 2 ##

  def part2() do
    File.open("input.txt", [:read, :utf8], fn(f) ->
      numbers = IO.read(f, :all) |> parse_input |> transpose |> List.flatten
      shapes = Enum.chunk(numbers, 3)
      Enum.count(shapes, &is_valid/1)
    end)
  end

  def transpose([[]|_]), do: []
  def transpose(a) do
    [Enum.map(a, &hd/1) | transpose(Enum.map(a, &tl/1))]
  end
end
