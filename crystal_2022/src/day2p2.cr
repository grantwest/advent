class RPS
  enum Move
    Rock
    Paper
    Scissors

    def loses_to
      case self
      when Rock     then Paper
      when Paper    then Scissors
      when Scissors then Rock
      else               raise "invalid move"
      end
    end

    def beats
      case self
      when Rock     then Scissors
      when Paper    then Rock
      when Scissors then Paper
      else               raise "invalid move"
      end
    end
  end

  enum MatchOutcome
    Win
    Lose
    Draw
  end

  Win  = MatchOutcome::Win
  Lose = MatchOutcome::Lose
  Draw = MatchOutcome::Draw

  def self.outcome(move_pair : {Move, Move})
    their_move, my_move = move_pair
    case
    when my_move == their_move          then Draw
    when my_move.beats == their_move    then Win
    when my_move.loses_to == their_move then Lose
    else                                     raise "invalid"
    end
  end

  def self.score(move_pair : {Move, Move})
    their_move, my_move = move_pair
    move_value = RPS.move_value(my_move)
    case outcome(move_pair)
    when Win  then 6 + move_value
    when Draw then 3 + move_value
    when Lose then 0 + move_value
    else           raise "unknown result"
    end
  end

  def self.parse_move(move_character)
    case move_character
    when "A" then Move::Rock
    when "B" then Move::Paper
    when "C" then Move::Scissors
    else          raise Exception.new("Invalid move")
    end
  end

  def self.parse_outcome(outcome_character)
    case outcome_character
    when "X" then Lose
    when "Y" then Draw
    when "Z" then Win
    else          raise Exception.new("Invalid outcome")
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

  def self.calculate_move(their_move : Move, outcome : MatchOutcome) : Move
    case outcome
    when Win  then their_move.loses_to
    when Draw then their_move
    when Lose then their_move.beats
    else           raise "invalid"
    end
  end
end

input = File.read("input/day2.txt")

total_score =
  input
    .split("\n")
    .map { |line|
      their_move_str, outcome_str = line.split(" ")
      their_move = RPS.parse_move(their_move_str)
      outcome = RPS.parse_outcome(outcome_str)
      my_move = RPS.calculate_move(their_move, outcome)
      RPS.score({their_move, my_move})
    }
    .sum

puts total_score
