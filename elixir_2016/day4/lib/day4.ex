defmodule Day4 do

  def part1 do
    File.open("input.txt", [:read, :utf8], fn(f) ->
      IO.read(f, :all)
      |> String.split("\n")
      |> Enum.filter(&(String.length(&1) > 0))
      |> Enum.map(&parse_room/1)
      |> Enum.filter(&is_real?/1)
      |> Enum.map(&(&1[:sid]))
      |> Enum.sum
    end)
  end

  def parse_room(room_str) do
    regex = ~r/(?<name>[a-z|-]*)-(?<sid>[0-9]*)\[(?<crc>[a-z]*)\]/
    %{"name" => name, "sid" => sid, "crc" => crc} = Regex.named_captures(regex, room_str)
    %{
      crc: crc, 
      sid: String.to_integer(sid), 
      name: name
    }
  end

  def is_real?(%{crc: crc, name: name}) do
    crc == calc_crc(name)
  end

  def calc_crc(name) do
    String.replace(name, "-", "")
    |> character_counts
    |> MapSet.to_list
    |> Enum.sort(fn({letter1, count1}, {letter2, count2}) -> count1 > count2 || (count1 == count2 && letter1 < letter2) end)
    |> Enum.map(fn({letter, _}) -> letter end)
    |> Enum.take(5)
    |> Enum.join("")
  end

  def character_counts(str) do
    String.graphemes(str)
    |> Enum.group_by(&(&1))
    |> Enum.map(fn({letter, list}) -> {letter, Enum.count(list)} end)
    |> MapSet.new
  end

  ## Part 2 ##
  def part2() do
    File.open("input.txt", [:read, :utf8], fn(f) ->
      IO.read(f, :all)
      |> String.split("\n")
      |> Enum.filter(&(String.length(&1) > 0))
      |> Enum.map(&parse_room/1)
      |> Enum.filter(&is_real?/1)
      |> Enum.map(&decrypt/1)
      |> Enum.filter(&(String.contains?(&1[:name], "northpole")))
    end)
  end

  def decrypt(room) do
    name = String.graphemes(room[:name])
      |> Enum.map(&(decrypt(&1, room[:sid])))
      |> Enum.join("")
    %{room | name: name}
  end

  def decrypt(char, sid) do
    case char do
      "-" -> " "
      a ->  to_string [rem((List.first(String.to_charlist(a)) - 97) + sid, 26) + 97]
    end
  end
end
