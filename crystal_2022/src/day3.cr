class RPS
  enum Move
    Rock
    Paper
    Scissors
  end

  enum MatchOutcome
    Win
    Lose
    Draw
  end

  Rock     = Move::Rock
  Paper    = Move::Paper
  Scissors = Move::Scissors

  def self.outcome(move_pair : {Move, Move})
    case move_pair
    when {Rock, Paper}, {Paper, Scissors}, {Scissors, Rock} then MatchOutcome::Win
    when {Rock, Rock}, {Paper, Paper}, {Scissors, Scissors} then MatchOutcome::Draw
    else                                                         MatchOutcome::Lose
    end
  end

  def self.score(move_pair : {Move, Move})
    their_move, my_move = move_pair
    move_value = RPS.move_value(my_move)
    case outcome(move_pair)
    when MatchOutcome::Win  then 6 + move_value
    when MatchOutcome::Draw then 3 + move_value
    when MatchOutcome::Lose then 0 + move_value
    else                         raise "unknown result"
    end
  end

  def self.parse_move(move_character)
    case move_character
    when "A", "X" then Rock
    when "B", "Y" then Paper
    when "C", "Z" then Scissors
    else               raise Exception.new("Invalid move")
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
    .map(&.split(" ").map { |move_str| RPS.parse_move(move_str) })
    .map { |moves|
      their_move, my_move = moves
      {their_move, my_move}
    }
    .map { |moves| RPS.score(moves) }
    .sum

puts total_score
