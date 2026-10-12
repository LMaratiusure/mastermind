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

  def read_guesses
    Array.new(Config::CODE_LENGTH) { |index| read_peg(index + 1) }
  end

  def play
    won = (1..Config::MAX_TURNS).any? do |round|
      guess = play_round(round)
      @code_maker.solution_found?(guess)
    end
    puts @code_maker.secret_code
    puts won ? 'You won!' : 'You lost!'
  end

  private

  def make_pegs(number_of_pegs)
    Config::COLORS.first(number_of_pegs).map { |color| Peg.new(color) }
  end

  def play_round(round)
    @guessing_holes.print_board
    puts "\nMake your choice from the list of pegs: "
    puts @pegs.map(&:color).join(', ')

    guess = read_guesses
    puts "\nRound #{round}:"
    @guessing_holes.insert_pegs(guess, @code_maker.hints_for(guess))
    guess
  end

  def read_peg(hole)
    loop do
      puts "Peg for hole #{hole}:"
      peg = Peg.new(read_line)
      return peg if @pegs.include?(peg)

      puts 'Please choose a peg from the list.'
    end
  end

  def read_line
    line = gets
    return line.strip if line

    puts "\nGoodBye!"
    exit
  end
end
