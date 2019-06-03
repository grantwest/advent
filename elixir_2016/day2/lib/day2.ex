defmodule Day2 do
  # require IEx

  def part1() do
    run({{0, 0}, &is_valid_pos1/1, &pos_to_key1/1})
  end

  def run(keypad) do
    {:ok, file} = File.open("input_part1.txt", [:read, :utf8])
    input = IO.read(file, :all)
    File.close(file)
    moves = input |> parse_input
    calculate_code(moves, keypad)
  end

  def parse_input(input) do
    input
    |> String.trim
    |> String.split("\n")
    |> Enum.map((line) -> Enum.map(String.graphemes(line), &char_to_move/1) end)
  end

  def calculate_code(movess, {starting_position, pos_check, pos_to_key}) do
    positions = Enum.scan(movess, starting_position, fn(moves, position) -> move_keys(position, moves, pos_check) end)
    keys = Enum.map(positions, pos_to_key)
    Enum.reduce(keys, "", fn(key, acc) -> acc <> key end)
  end

  def char_to_move(char) do
    case char do
          "U" -> :up
          "D" -> :down
          "L" -> :left
          "R" -> :right
    end
  end

  def move_keys(starting_position, directions, pos_check_fn) do
    Enum.reduce(directions, starting_position, fn(dir, pos) -> move_key(pos, dir, pos_check_fn) end)
  end

  def move_key({x, y}, direction, pos_check) do
    case direction do
      :down ->  position_check({x, y+1}, {x, y}, pos_check)
      :right -> position_check({x+1, y}, {x, y}, pos_check)
      :up ->    position_check({x, y-1}, {x, y}, pos_check)
      :left ->  position_check({x-1, y}, {x, y}, pos_check)
    end
  end

  def position_check(new, original, pos_check_fn) do
    case pos_check_fn.(new) do
      true -> new
      false -> original
    end
  end

  def is_valid_pos1({x, y}) do
    x >= 0 and y >= 0 and x < 3 and y < 3
  end

  def pos_to_key1({x, y}) do
    Integer.to_string(1 + x + 3 * y)
  end

  ## Part 2 ##

  def part2() do
    run({{0, 0}, &is_valid_pos2/1, &pos_to_key2/1})
  end

  def is_valid_pos2({x, y}) do
    abs(x) + abs(y) <= 2
  end

  def pos_to_key2({x, y}) do
    Integer.to_string(7 + (5 - abs(y))*y + x, 16)
  end

end
