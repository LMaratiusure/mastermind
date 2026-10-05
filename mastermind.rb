require_relative 'code_maker'
require_relative 'code_breaker'
require_relative 'guessing_holes'
require_relative 'hinting_holes'
require_relative 'peg'
require_relative 'secret_code_holes'

class Mastermind
  COLORS = ["Red", "Pink", "Orange", "Yellow", "Green", "Blue", "Purple", "Brown", "Gray", "Gold", "Silver"]
  MAX_TURNS = 12

  def initialize
    @code_maker = CodeMaker.new
    @code_breaker = CodeBreaker.new
    @guessing_holes = GuessingHoles.new
    @hinting_holes = HintingHoles.new
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
        color = gets.chomp.strip.downcase

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

      puts "--------------------------------------"
      puts "Make your choice from the list of pegs: "
      puts @pegs.map(&:color).join(', ')
      
      get_guesses
      
      p "Round #{index + 1} hints:"
      @guessing_holes.insert_pegs(@guesses)
      hints = @code_maker.get_hints(@guesses)
      puts hints.positions.map(&:color).join(', ')
      puts "----------------"
      
      if @code_maker.solution_found?
        puts "You won!"
        p @code_maker.secret_code
        @code_maker.clear_hints
        return
      end
      @code_maker.clear_hints
    end
    p @code_maker.secret_code
    puts "You lost!"
  end
end
