# frozen_string_literal: true

require_relative 'serializer'
require_relative 'word_checker'
require_relative 'display'

# Define class Game that manages gameflow
class Game
  include Serializer
  include WordChecker
  include Display

  # Ask whether to start new game or load savestate on initialization, then start game
  def initialize
    select_word
  end

  private

  # Play rounds until save is requested or game ends
  def play_game
  end

  # Play out one round of hangman
  def play_round
  end

  def select_saves
  end

  def select_word
    viable_words = File.open('../10000-english-no-swears.txt') do |file|
      file.readlines.filter { |word| word.chomp.length.between?(5, 12) }
    end
    @solution = viable_words.sample
  end

end