require_relative 'player'
require 'json'
class Game
  attr_reader :human, :computer

  def initialize(human = 0, computer = 0, word = nil, feedback = nil, turn = 1,
                 chosen = [])
    @human = Player.new(human)
    @computer = Player.new(computer)
    @word = word || @computer.choose_word
    @feedback = feedback || Array.new(@word.length) { '_' }
    @turn = turn
    @chosen = chosen
  end

  def play
    while @turn <= 8
      puts "\n🔁 Save turn? (y/n)"
      print 'Your answer: '
      continue = gets.chomp.downcase
      if continue == 'y'
        save
        return
      end
      puts "\n🔁 Turn #{@turn}"
      print 'Chosen words: '
      puts print @chosen
      print '🎯 Enter your guess: '
      guess = @human.guess_word
      @chosen.push(guess) unless @chosen.include?(guess)
      @feedback = @computer.check_word(guess, @word, @feedback)
      puts "🧠 Feedback from the computer: #{@feedback}"

      if @feedback.join('') == @word
        puts "\n🏆 You cracked the word!"
        @human.score += 1
        return
      end
      @turn += 1
    end

    puts "\n❌ You've run out of guesses!"
    puts "🔐 The correct code was: #{@word}"
    @computer.score += 1
  end

  def save
    File.write('save.json', JSON.dump({
                                        human: @human.score,
                                        computer: computer.score,
                                        word: @word,
                                        feedback: @feedback,
                                        turn: @turn,
                                        chosen: @chosen
                                      }))
  end

  def self.load(string)
    data = JSON.load string
    new(data['human'], data['computer'], data['word'], data['feedback'], data['turn'], data['chosen'])
  end
end
