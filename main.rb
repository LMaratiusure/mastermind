require_relative 'mastermind'

begin
  Mastermind.new.play
rescue Interrupt
  puts "\nGoodBye"
end
