require_relative 'mastermind'
require_relative 'config'

begin
  Mastermind.new(Config::NUMBER_OF_COLORS).play
rescue Interrupt
  puts "\nGoodBye"
end
