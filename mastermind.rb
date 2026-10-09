require_relative 'code_maker'
require_relative 'guessing_holes'
require_relative 'peg'
require_relative 'secret_code_holes'
require_relative 'config'

class Mastermind

  def initialize(number_of_pegs)
    @pegs = make_pegs(number_of_pegs)
    @code_maker = CodeMaker.new(@pegs)
    @guessing_holes = GuessingHoles.new
  end

  def get_guesses
    guess = Array.new(Config::CODE_LENGTH) do |index|
      loop do
        puts "Peg for hole #{index + 1}:"
        color = gets&.strip
        if color.nil?
          puts "\nGoodBye!"
          exit
        end

        peg = Peg.new(color)
        break peg if @pegs.include?(peg)

        puts "Please choose a peg from the list."
      end
    end
    guess
  end

  def play
    Config::MAX_TURNS.times do |index|
      @guessing_holes.print_board

      puts "\nMake your choice from the list of pegs: "
      puts @pegs.map(&:color).join(', ')
      
      guess = get_guesses
      
      puts "\nRound #{index + 1}:"

      hints = @code_maker.hints_for(guess)
      @guessing_holes.insert_pegs(guess, hints)
      
      if @code_maker.solution_found?(guess)
        puts "You won!"
        puts @code_maker.secret_code
        return
      end
    end
    puts @code_maker.secret_code
    puts "You lost!"
  end

  private

  def make_pegs(number_of_pegs)
    Config::COLORS.first(number_of_pegs).map { |color| Peg.new(color) }
  end

end
