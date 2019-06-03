defmodule Day7 do

  def part1() do
    File.open("input.txt", [:read, :utf8], fn(f) ->
      IO.read(f, :all)
      |> String.split("\n")
      |> Enum.filter(&(String.length(&1) > 0))
      |> Enum.map(&parse_ipv7/1)
      |> Enum.count(&tls?/1)
    end)
    |> elem(1)
  end

  def parse_ipv7(ip) do
    parts = String.split(ip, ~r/[\[|\]]/)
    %{
      supernets: Enum.take_every(parts, 2),
      hypernets: Enum.take_every(tl(parts), 2)
    }
  end

  def abba?([a, b, c, d]), do: a == d and b == c and a != b

  def abba?(seq) do
    if String.length(seq) < 4 do
      false
    else
      String.graphemes(seq)
      |> Enum.chunk(4, 1)
      |> Enum.any?(&(abba?(&1)))
    end
  end

  def tls?(%{supernets: supernets, hypernets: hypernets}) do
    Enum.any?(supernets, &abba?/1) and not Enum.any?(hypernets, &abba?/1)
  end

  ## Part 2 ##
  def aba([a, b, c]), do: a == c and a != b

  def aba(seq) do
    if String.length(seq) < 3 do
      []
    else
      String.graphemes(seq)
      |> Enum.chunk(3, 1)
      |> Enum.filter(&(aba(&1)))
      |> Enum.map(&(Enum.join(&1, "")))
    end
  end

  def aba_to_bab(aba) do
    [a, b, a] = String.graphemes(aba)
    b <> a <> b
  end

  def ssl?(%{supernets: supernets, hypernets: hypernets}) do
    super_abas = supernets |> Enum.flat_map(&aba/1) |> MapSet.new
    hyper_abas =  hypernets |> Enum.flat_map(&aba/1) |> Enum.map(&aba_to_bab/1) |> MapSet.new
    not MapSet.disjoint?(super_abas, hyper_abas) 
  end

  def part2() do
    File.open("input.txt", [:read, :utf8], fn(f) ->
      IO.read(f, :all)
      |> String.split("\n")
      |> Enum.filter(&(String.length(&1) > 0))
      |> Enum.map(&parse_ipv7/1)
      |> Enum.count(&ssl?/1)
    end)
    |> elem(1)
  end
end
