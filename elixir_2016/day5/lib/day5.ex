defmodule Day5 do

  def part1(door_id) do
    id_index_stream(door_id)
    |> Stream.map(&md5/1)
    |> Stream.filter(&(leading_zeros(&1) >= 5))
    |> Stream.map(&(String.at(&1, 5)))
    |> Stream.take(8)
    |> Enum.join("")
  end

  def id_index_stream(id) do
    Stream.iterate(0, &(&1 + 1))
    |> Stream.map(&Integer.to_string/1)
    |> Stream.map(&(id <> &1))
  end

  def md5(string) do
    :crypto.hash(:md5, string) |> Base.encode16 |> String.downcase
  end

  def leading_zeros(string) do
    String.graphemes(string)
    |> Enum.take_while(&(&1 == "0"))
    |> Enum.count
  end

  # def parallelize(stream, chunk_size, enum_operator) do
  #   Stream.chunk(stream, chunk_size)
  #   |> ParallelStream.map(fn(enum) -> enum_operator.(enum) end)
  #   |> Stream.concat
  # end

  ## Part 2 ##

  def part2(door_id) do
    id_index_stream(door_id)
    |> Stream.map(&md5/1)
    |> Stream.filter(&(leading_zeros(&1) >= 5))
    |> Stream.map(&({String.at(&1, 5) |> String.to_integer(16), String.at(&1, 6)}))
    |> Stream.filter(fn({position, key}) -> position < 8 end)
    |> Stream.scan({nil, nil, nil, nil, nil, nil, nil, nil}, fn({pos, key}, code) -> 
        cond do
          elem(code, pos) == nil -> put_elem(code, pos, key)
          true -> code
        end
      end)
    |> Stream.map(&Tuple.to_list/1)
    |> Stream.filter(fn(code) -> Enum.all?(code, &(&1)) end)
    |> Stream.take(1)
    |> Enum.join("")
  end

end
