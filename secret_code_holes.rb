class SecretCodeHoles
  attr_reader :pegs
  
  def initialize(pegs)
    @pegs = pegs.freeze
  end

  def to_s
    pegs.join(' | ')
  end
end
