enum Move
  Rock
  Paper
  Scissors

  def self.parse(move_character)
    case move_character
    when "A", "X" then Rock
    when "B", "Y" then Paper
    when "C", "Z" then Scissors
    else               raise Exception.new("Invalid move")
    end
  end
end

class Match
  Rock     = Move::Rock
  Paper    = Move::Paper
  Scissors = Move::Scissors

  def initialize(their_move : Move, my_move : Move)
    @move_pair = {their_move, my_move}
  end

  enum MatchOutcome
    Win
    Lose
    Draw
  end

  def result
    case @move_pair
    when {Rock, Paper}, {Paper, Scissors}, {Scissors, Rock} then MatchOutcome::Win
    when {Rock, Rock}, {Paper, Paper}, {Scissors, Scissors} then MatchOutcome::Draw
    else                                                         MatchOutcome::Lose
    end
  end

  def score
    their_move, my_move = @move_pair
    move_value = Match.move_value(my_move)
    case result()
    when MatchOutcome::Win  then 6 + move_value
    when MatchOutcome::Draw then 3 + move_value
    when MatchOutcome::Lose then 0 + move_value
    else                         raise "unknown result"
    end
  end

  def self.move_value(move : Move) : Int32
    case move
    when Move::Rock     then 1
    when Move::Paper    then 2
    when Move::Scissors then 3
    else                     raise "unknown move: #{move}"
    end
  end
end

input = File.read("input/day2.txt")

total_score =
  input
    .split("\n")
    .map(&.split(" ").map { |move_str| Move.parse(move_str) })
    .map { |moves|
      their_move, my_move = moves
      Match.new(their_move, my_move)
    }
    .map(&.score())
    .sum

puts total_score
