defmodule Day2 do
  def part1() do
    File.open("input.txt", [:read, :utf8], fn(f) ->
      IO.read(f, :all)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.split/1)
      |> Enum.map(fn(nums) -> Enum.map(nums, &String.to_integer/1) end)
      |> Enum.map(&largest_difference/1)
      |> Enum.sum()
    end)
  end

  def largest_difference([]), do: 0
  def largest_difference(numbers) do
    Enum.max(numbers) - Enum.min(numbers)
  end

  # Part 2 ##############################################

  def part2() do
    File.open("input.txt", [:read, :utf8], fn(f) ->
      IO.read(f, :all)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.split/1)
      |> Enum.map(fn(nums) -> Enum.map(nums, &String.to_integer/1) end)
      |> Enum.map(&whole_quotient/1)
      |> Enum.sum()
    end)
  end

  def whole_quotient(numbers) do
    cartesian_product(numbers)
    |> Enum.filter(fn({n1, n2}) -> n1 != n2 end)
    |> Enum.filter(fn({_, n2}) -> n2 != 0 end)
    |> Enum.filter(fn({n1, n2}) -> rem(n1, n2) == 0 end)
    |> Enum.map(fn({n1, n2}) -> div(n1, n2) end)
    |> hd()
  end

  defp cartesian_product(list) do
    Enum.flat_map(list, fn(n1) -> Enum.map(list, fn(n2) -> {n1, n2} end) end)
  end

end
