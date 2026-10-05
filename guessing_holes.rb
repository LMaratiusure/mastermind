require_relative 'peg'
class GuessingHoles
  attr_reader :current_row
  def initialize
    @positions = Array.new(12) {[1,2,3,4]}
    @current_row = 0
  end

  def insert_pegs(pegs)
    return nil unless pegs.length == 4

    @positions[current_row] = pegs
    @current_row += 1
  end

  def print_board
    @current_row.times do |i|
      puts @positions[i].map(&:color).join(' | ')
    end
  end

end
