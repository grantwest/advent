defmodule Day6 do

  def part1() do
    File.open("input.txt", [:read, :utf8], fn(f) ->
      IO.read(f, :all)
      |> reconstruct(&mode/1)
    end)
    |> elem(1)
  end

  def parse(input) do
    String.split(input, "\n")
    |> Enum.filter(&(String.length(&1) > 0))
    |> Enum.map(&String.graphemes/1)
    |> transpose
  end

  def reconstruct(messages, character_selector) do
    parse(messages)
    |> Enum.map(character_selector)
    |> Enum.join
  end

  def mode(list) do
    Enum.group_by(list, &(&1))
    |> Enum.map(fn({letter, ls}) -> {letter, Enum.count(ls)} end)
    |> Enum.max_by(&(elem(&1, 1)))
    |> elem(0)
  end

  def transpose([[]|_]), do: []
  def transpose(a) do
    [Enum.map(a, &hd/1) | transpose(Enum.map(a, &tl/1))]
  end

  ## Part 2 ##
  def part2() do
    File.open("input.txt", [:read, :utf8], fn(f) ->
      IO.read(f, :all)
      |> reconstruct(&least_common/1)
    end)
    |> elem(1)
  end

  def least_common(list) do
    Enum.group_by(list, &(&1))
    |> Enum.map(fn({letter, ls}) -> {letter, Enum.count(ls)} end)
    |> Enum.min_by(&(elem(&1, 1)))
    |> elem(0)
  end

end
