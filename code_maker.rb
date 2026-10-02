require_relative 'peg'
require_relative 'secret_code'
require_relative 'hinting_holes'

class CodeMaker
  attr_reader :secret_code, :hints

  def initialize
    @pegs = []
    @secret_code = SecretCodeHoles.new
    @random = Random.new
    @hints = HintingHoles.new
  end

  def make_code(pegs)
    4.times do |i|
      random_number = @random.rand(5)
      @pegs[i] = pegs[random_number]
    end
    @secret_code.positions = @pegs
  end

  def get_hints(guesses)
    # a hash with colors as a key and positions in an array as a value
    secret = get_colors_positions(secret_code.positions)
    break_code = get_colors_positions(guesses)

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

  def solution_found
    count = 0
    hints.positions.each do |peg|
      count += 1 unless peg.color != 'black'
    end
    count == 4
  end

  private

  def get_colors_positions(code)
    color_positions = Hash.new { |hash, color| hash[color] = [] }
    code.each_with_index do |peg, index|
      color_positions[peg.color.downcase] << index
    end
    color_positions
  end
  
end
