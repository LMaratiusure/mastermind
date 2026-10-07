require_relative 'peg'
require_relative 'config'
class GuessingHoles
  attr_reader :current_row
  def initialize
    @positions = Array.new(Config::MAX_TURNS) {Array.new(Config::CODE_LENGTH)}
    @current_row = 0
  end

  def insert_pegs(pegs)
    return nil unless pegs.length == Config::CODE_LENGTH

    @positions[current_row] = pegs
    @current_row += 1
  end

  def print_board
    @current_row.times do |i|
      puts @positions[i].map(&:color).join(' | ')
    end
  end

end
