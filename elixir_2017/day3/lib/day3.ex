defmodule Day3 do
  
  def part1(square_id) do
    {x, y} = position(square_id)
    abs(x) + abs(y)
  end

  def  ring(square_id), do: ring(square_id, 1, 1, 1)
  defp ring(sid, ring_num,  min, max) when sid >= min and sid <= max, do: ring(ring_num, min, max)
  defp ring(sid, ring_num, _min, max), do: ring(sid, ring_num+1, max+1, max+(8*ring_num))
  defp ring(ring_num, min, max) do
    ring_start_x = ring_num - 1
    ring_start_y = min(0, 2 - ring_num)
    %{
      num: ring_num, 
      min_id: min, 
      max_id: max, 
      dimension: 2 * ring_num - 1,
      start_xy: {ring_start_x, ring_start_y}
    }
  end

  def position(square_id) do
    ring = ring(square_id)
    position(ring[:start_xy], square_id - ring[:min_id], ring[:dimension], :up)
  end
  
  defp position(pos, 0, _dim, _dir), do: pos
  defp position({x, y}, r, dimension, :up)    when r < (dimension - 1), do: {x, y + r}
  defp position({x, y}, r, dimension, :left)  when r < dimension, do: {x - r, y}
  defp position({x, y}, r, dimension, :down)  when r < dimension, do: {x, y - r}
  defp position({x, y}, r, dimension, :right) when r < dimension, do: {x + r, y}
  defp position({x, y}, r, dim, :up), do: position({x, y + dim - 2}, r - dim + 2, dim, :left)
  defp position({x, y}, r, dim, :left), do: position({x - dim + 1, y}, r - dim + 1, dim, :down)
  defp position({x, y}, r, dim, :down), do: position({x, y - dim + 1}, r - dim + 1, dim, :right)

  # Part 2 ##############################################

  def part2(input) do
    Stream.iterate(1, &(&1 + 1))
      |> Stream.map(&value/1)
      |> Stream.filter(&(&1 > input))
      |> Stream.take(1)
      |> Enum.to_list()
      |> hd()
  end

  def value(square_id) do
    1 .. square_id
      |> Enum.reduce(%{}, fn(sid, mem) -> Map.put(mem, position(sid), value(sid, mem)) end)
      |> Map.get(position(square_id))
  end
  defp value(1, _mem), do: 1
  defp value(square_id, mem) do
    {x, y} = position(square_id)
    [{x+1, y}, {x+1, y+1}, {x, y+1}, {x-1, y+1}, {x-1, y}, {x-1, y-1}, {x, y-1}, {x+1, y-1}]
      |> Enum.map(fn(pos) -> Map.get(mem, pos, 0) end)
      |> Enum.sum()
  end

end
