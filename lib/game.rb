# frozen_string_literal: true

require 'json'
require_relative 'word_checker'
require_relative 'display'

# Define class Game that manages gameflow
class Game
  include WordChecker
  include Display

  attr_reader :round, :solution, :misses, :hits

  # Ask whether to start new game or load savestate on initialization, then start game
  def initialize(round: 0, solution: nil, misses: [], hits: [])
    # save_name = get_save_name
    # @path = "./saves/#{save_name}.txt"
    @round = round
    solution || @solution = select_word
    @misses = misses
    @hits = hits
    set_solution_variables
  end

  def self.json_create(gamestate)
    new(round: gamestate[:round], solution: gamestate[:solution], misses: gamestate[:misses], hits: gamestate[:hits])
  end

  def to_json(*)
    JSON.dump({
      JSON.create_id => self.class.name,
      :round => @round,
      :solution => @solution,
      :misses => @misses,
      :hits => @hits
    })
  end

  def save_game
    File.open(@path, 'w') do |file|
      JSON.dump(self, file)
    end
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
    viable_words = File.open('./10000-english-no-swears.txt') do |file|
      file.readlines.filter { |word| word.chomp.length.between?(5, 12) }
    end
    viable_words.sample.chomp
  end
end

test = Game.new
p test
# test.save_game
# test2 = File.open('./saves/test.txt', 'r') do |file|
#   JSON.parse(file.gets, create_additions: true)
# end
# p test2