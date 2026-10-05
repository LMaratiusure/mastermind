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
    # a hash with colors as a key and positions in an array as a value
    secret = color_positions(secret_code.positions)
    break_code = color_positions(guesses)

    break_code.each do |color, value|
      if secret.include?(color)
        secret[color].intersection(break_code[color]).length.times do
          hints.positions.push(Peg.new('black'))
        end
        (secret[color] - break_code[color]).length.times do
          hints.positions.push(Peg.new('white'))
        end
      end
    end
    hints
  end

  def clear_hints
    @hints.clear
  end

  def solution_found?
    hints.positions.count { |peg| peg.color == 'black' } == CODE_LENGTH
  end

  private

  def color_positions(code)
    color_positions = Hash.new { |hash, color| hash[color] = [] }
    code.each_with_index do |peg, index|
      color_positions[peg.color.downcase] << index
    end
    color_positions
  end
  
end
