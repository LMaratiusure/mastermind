require_relative 'peg'
require_relative 'secret_code_holes'

class CodeMaker
  CODE_LENGTH = 4
  attr_reader :secret_code

  def initialize
    @secret_code = SecretCodeHoles.new
  end

  def make_code(pegs)
    @secret_code.positions = Array.new(CODE_LENGTH) { pegs.sample }
  end

  def hints_for(guesses)
    secret = secret_code.positions.map { |peg| peg.color.downcase }
    guess = guesses.map { |peg| peg.color.downcase }

    blacks = secret.zip(guess).count { |s, g| s == g }
    common = secret.uniq.sum { |color| [secret.count(color), guess.count(color)].min }

    { black: blacks, white: common - blacks}
  end

  def solution_found?(guesses)
    hints_for(guesses)[:black] == CODE_LENGTH
  end
  
end
