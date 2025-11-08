require_relative('lib/player')
require_relative('lib/game')
require 'json'

game = Game.new

puts "\n🔁 Load your save? (y/n)"
print 'Your answer: '
load = gets.chomp.downcase
game = Game.load(File.read('save.json')) if load == 'y'

loop do
  puts "\n🎲 New game begins!"
  game.play

  puts "\n📊 Current Scores:"
  puts "🧑 Human: #{game.human.score}"
  puts "🤖 Computer: #{game.computer.score}"

  puts "\n🔁 Play again? (y/n)"
  print 'Your answer: '
  continue = gets.chomp.downcase
  break unless continue == 'y'

  game = Game.new
end

puts "\n👋 Thanks for playing"
