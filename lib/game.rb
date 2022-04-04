# frozen_string_literal: true

require 'json'
require_relative 'word_checker'
require_relative 'display'

# Define class Game that manages gameflow
class Game
  include WordChecker
  include Display

  attr_reader :round, :solution, :misses, :hits, :save_game, :game_over
  alias save_game? save_game
  alias game_over? game_over

  # Ask whether to start new game or load savestate on initialization, then start game
  def initialize(round: 0, solution: nil, misses: [], hits: [])
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

  # Play out one round of hangman
  def play_round
    @round += 1
    display_hidden_word
    puts "Round #{@round}: "
    user_action
  end

  private

  # Play rounds until save is requested or game ends
  def play_game
  end


  def user_action
    case user_action_choice
    when '1'
      guess_letter
    when '2'
      guess_word
    when '3'
      @save_game = true
    end
  end

  def guess_letter
    check_letter(ask_for_letter)
  end

  def select_word
    viable_words = File.open('./10000-english-no-swears.txt') do |file|
      file.readlines.filter { |word| word.chomp.length.between?(5, 12) }
    end
    viable_words.sample.chomp
  end
end

test = Game.new
#test.check_letter('e')
#p test.hits
#p test.misses


# Code to load a game object from save file
# test2 = JSON.parse(File.read('./saves/FILENAME'))
