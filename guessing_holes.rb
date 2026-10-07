require_relative 'peg'
require_relative 'config'
class GuessingHoles
  attr_reader :current_row
  def initialize
    @positions = []
  end

  def insert_pegs(pegs)
    unless pegs.length == Config::CODE_LENGTH
      raise ArgumentError,
      "expected #{Config::CODE_LENGTH} pegs, got #{pegs.length}"
    end
    
    @positions << pegs
  end

  def current_row
    @positions.length
  end

  def print_board
    @positions.each do |row|
      puts row.map(&:color).join(' | ')
    end
  end

end
