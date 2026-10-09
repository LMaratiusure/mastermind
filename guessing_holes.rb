require_relative 'config'
class GuessingHoles
  def initialize
    @positions = []
  end

  def insert_pegs(pegs, hints)
    unless pegs.length == Config::CODE_LENGTH
      raise ArgumentError,
      "expected #{Config::CODE_LENGTH} pegs, got #{pegs.length}"
    end

    @positions << [pegs, hints]
  end

  def print_board
    @positions.each do |guess, hints|
      puts "#{guess.map(&:color).join(' | ')} | Hints: Black: #{hints[:black]}, White: #{hints[:white]}"
    end
  end

end
