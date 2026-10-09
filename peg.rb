class Peg
  attr_reader :color

  def initialize(color)
    @color = color.downcase
  end

  def ==(other)
    other.is_a?(Peg) && color == other.color
  end
  alias eql? ==

  def hash
    color.hash
  end

  def to_s
    color
  end
end
