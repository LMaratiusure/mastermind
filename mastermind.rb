require_relative 'code_maker'
require_relative 'guessing_holes'
require_relative 'peg'
require_relative 'secret_code_holes'

class Mastermind
  COLORS = ["Red", "Pink", "Orange", "Yellow", "Green", "Blue", "Purple", "Brown", "Gray", "Gold", "Silver"]
  MAX_TURNS = 12

  def initialize
    @code_maker = CodeMaker.new
    @guessing_holes = GuessingHoles.new
    @pegs = []
    @guesses = Array.new(4)
  end

  def make_pegs(num)
    amount = num < COLORS.length ? num : COLORS.length
    amount.times do |i|
      @pegs.push(Peg.new(COLORS[i]))
    end
  end

  def get_guesses
    allowed_colors = @pegs.map { |peg| peg.color.downcase }

    @guesses = Array.new(4) do |index|
      loop do
        puts "Color for hole #{index + 1}:"
        color = gets&.strip&.downcase
        if color.nil?
          puts "\nGoodbye!"
          exit
        end

        break Peg.new(color) if allowed_colors.include?(color)

        puts "Please choose a color from the list."
      end
    end
  end

  def play
    make_pegs(6)
    @code_maker.make_code(@pegs)

    MAX_TURNS.times do |index|
      @guessing_holes.print_board

      puts "Make your choice from the list of pegs: "
      puts @pegs.map(&:color).join(', ')
      
      get_guesses
      
      puts "Round #{index + 1} hints:"
      @guessing_holes.insert_pegs(@guesses)

      hints = @code_maker.hints_for(@guesses)
      puts "Black: #{hints[:black]}, White: #{hints[:white]}"
      
      if @code_maker.solution_found?(@guesses)
        puts "You won!"
        puts @code_maker.secret_code.positions.map(&:color).join(' | ')
        return
      end
    end
    puts @code_maker.secret_code.positions.map(&:color).join(' | ')
    puts "You lost!"
  end
end
