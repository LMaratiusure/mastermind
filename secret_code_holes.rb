require_relative 'config'
class SecretCodeHoles
  attr_accessor :positions
  
  def initialize
    @positions = Array.new(Config::CODE_LENGTH)
  end
end
