require 'json'

class Player
  def initialize(score)
    @score = score
  end

  attr_accessor :score

  def choose_word
    dict = File.readlines('google-10000-english-no-swears.txt')
    dict = dict.select { |w| w.length.between?(6, 13) }
    dict.sample.chomp.split('')
  end

  def guess_word
    gets.chomp.downcase
  end

  def check_word(guess, word, feedback)
    if word.include?(guess)
      indexes = word.each_index.select { |i| word[i] == guess }
      indexes.each { |i| feedback[i] = guess }
    end
    feedback
  end
end
