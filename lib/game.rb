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
    @solution = solution
    @solution = select_word if @solution.nil?
    @misses = misses
    @hits = hits
    play_game
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
    puts "Round #{@round}: "
    display_hidden_word
    puts "Hits: #{@hits.join(' ')}"
    puts "Misses: #{@misses.join(' ')}"
    user_action
  end

    # Play rounds until save is requested or game ends
  def play_game
    set_solution_variables
    puts @solution
    @hits.each { |letter| check_letter(letter) }
    until @game_over || @round == 8
      play_round
    end
  end

  private

  def user_action
    case user_action_choice
    when '1'
      check_letter(ask_for_letter)
    when '2'
      guess_word
    when '3'
      save_game
    end
  end

  def guess_word
    if correct_word?(ask_for_guess)
      correct_guess
      @game_over = true
    else
      incorrect_guess
    end
  end

  def select_word
    viable_words = File.open('./10000-english-no-swears.txt') do |file|
      file.readlines.filter { |word| word.chomp.length.between?(5, 12) }
    end
    viable_words.sample.chomp
  end

  def save_game
    save_name = get_save_name
    @path = "./saves/#{save_name}.txt"
    File.open(@path, 'w') do |file|
      JSON.dump(self, file)
    end
    @game_over = true
  end
end

#test = JSON.parse(File.read('./saves/test game.txt'), create_additions: true)
game = Game.new(round: 2, solution: 'melodies', misses: [], hits: ['s'])
p game
#test.check_letter('e')
#p test.hits
#p test.misses


# Code to load a game object from save file
# test2 = JSON.parse(File.read('./saves/FILENAME'))
