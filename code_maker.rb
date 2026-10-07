require_relative 'peg'
require_relative 'secret_code_holes'
require_relative 'hinting_holes'

class CodeMaker
  CODE_LENGTH = 4
  attr_reader :secret_code, :hints

  def initialize
    @pegs = []
    @secret_code = SecretCodeHoles.new
    @random = Random.new
    @hints = HintingHoles.new
  end

  def make_code(pegs)
    @secret_code.positions = Array.new(CODE_LENGTH) { pegs.sample }
  end

  def get_hints(guesses)
    secret = secret_code.positions.map { |peg| peg.color.downcase }
    guess = guesses.map { |peg| peg.color.downcase }

    blacks = secret.zip(guess).count { |s, g| s == g }
    common = secret.uniq.sum { |color| [secret.count(color), guess.count(color)].min }
    whites = common - blacks

    blacks.times { hints.positions.push(Peg.new('black'))}
    whites.times { hints.positions.push(Peg.new('white'))}

    hints
  end

  def clear_hints
    @hints.clear
  end

  def solution_found?
    hints.positions.count { |peg| peg.color == 'black' } == CODE_LENGTH
  end
  
end
