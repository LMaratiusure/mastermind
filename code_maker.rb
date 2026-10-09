require_relative 'peg'
require_relative 'secret_code_holes'
require_relative 'config'

class CodeMaker
  attr_reader :secret_code

  def initialize(pegs)
    sampled_pegs = Array.new(Config::CODE_LENGTH) { pegs.sample }
    @secret_code = SecretCodeHoles.new(sampled_pegs)
  end

  def hints_for(guess)
    secret = secret_code.pegs

    blacks = secret.zip(guess).count { |s, g| s == g }
    common = secret.uniq.sum { |peg| [secret.count(peg), guess.count(peg)].min }

    { black: blacks, white: common - blacks}
  end

  def solution_found?(guess)
    guess == @secret_code.pegs
  end
  
end
