defmodule Day1 do

  def part1(input) do
    input |> parse_moves |> accumulate_moves |> distance
  end

  def parse_moves(moves_str) do
    moves_str |> String.split(",") |> Enum.map(&(&1 |> String.trim |> parse_move))
  end

  def parse_move(move_str) do
    {turn_str, blocks_str} = String.split_at(move_str, 1)
    blocks = String.to_integer(blocks_str)
    turn = %{"R" => :right, "L" => :left}[turn_str]
    [turn, blocks]
  end

  def distance(%{x: x, y: y}) do
    abs(x) + abs(y)
  end

  def accumulate_moves(moves) do 
    Enum.reduce(moves, %{x: 0, y: 0, heading: :north}, fn([turn, blocks], state) -> advance(turn(state, turn), blocks) end)
  end  

  def advance(state, blocks) do
    case state do
      %{heading: :north, y: y} -> %{state | y: y + blocks}
      %{heading: :east,  x: x} -> %{state | x: x + blocks}
      %{heading: :south, y: y} -> %{state | y: y - blocks}
      %{heading: :west,  x: x} -> %{state | x: x - blocks}
    end
  end

  def turn(state, left_or_right) do
    case {state[:heading], left_or_right} do
      {:north, :right} -> %{state | heading: :east}
      {:east,  :right} -> %{state | heading: :south}
      {:south, :right} -> %{state | heading: :west}
      {:west,  :right} -> %{state | heading: :north}
      {:north, :left} ->  %{state | heading: :west}
      {:west,  :left} ->  %{state | heading: :south}
      {:south, :left} ->  %{state | heading: :east}
      {:east,  :left} ->  %{state | heading: :north}
    end
  end


  ## Part 2 ##
  def part2(input) do
    input |> parse_moves |> moves_to_path |> first_duplicate |> distance
  end

  def first_duplicate(list) do
    case list do
      [] -> nil
      [_] -> nil
      [x | xs] -> if Enum.member?(xs, x), do: x, else: first_duplicate(xs)
    end
  end

  def moves_to_path(moves) do 
    starting_state = %{x: 0, y: 0, heading: :north}
    mss = Enum.scan(moves, [starting_state], fn([turn, blocks], states) -> advance_one_at_a_time(turn(List.last(states), turn), blocks) end)
    path_with_headings = [starting_state | List.flatten(mss)]
    Enum.map(path_with_headings, fn(state) -> Map.delete(state, :heading) end)
  end

  def advance_one_at_a_time(state, blocks) do
    case blocks do
      0 -> []
      _ -> Enum.scan(1..blocks, state, fn(_, state) -> advance(state, 1) end)
    end
  end

end
