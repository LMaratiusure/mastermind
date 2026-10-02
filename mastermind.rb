require_relative 'code_maker'
require_relative 'code_breaker'
require_relative 'guessing_holes'
require_relative 'hinting_holes'
require_relative 'peg'
require_relative 'secret_code'

class Mastermind
  COLORS = ["Red", "Pink", "Orange", "Yellow", "Green", "Blue", "Purple", "Brown", "Gray", "Gold", "Silver"]

  def initialize
    @code_maker = CodeMaker.new
    @code_breaker = CodeBreaker.new
    @guessing_holes = GuessingHoles.new
    @hinting_holes = HintingHoles.new
    @pegs = []
    @guesses = Array.new(4)
  end

  def make_pegs(num)
    amount = num < 11 ? num : 11
    amount.times do |i|
      @pegs.push(Peg.new(COLORS[i]))
    end
  end

  def get_guesses
    4.times do |i|
      puts "Color #{i + 1}: "
      color = gets.chomp

      puts "Hole number: "
      hole_number = gets.to_i

      chosen_peg = Peg.new(color)
      @guesses[hole_number - 1] = chosen_peg

      p @guesses
    end
  end

  def clear_guesses
    @guesses.clear
  end

  def play
    make_pegs(6)
    @code_maker.make_code(@pegs)

    12.times do 
      @guessing_holes.print_board

      puts "Make your choice from the list of pegs: "
      @pegs.each { |peg| p peg.color }
      
      get_guesses
      
      @guessing_holes.insert_pegs(@guesses)
      hints = @code_maker.get_hints(@guesses)
      p hints
      p @code_maker.secret_code

      if @code_maker.solution_found
        puts "You won!"
        @code_maker.clear_hints
        return
      end
      clear_guesses
      @code_maker.clear_hints
    end
    puts "You lost!"
  end
end
