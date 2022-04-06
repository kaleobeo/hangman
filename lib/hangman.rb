require_relative 'display'
require_relative 'game'
require 'json'

class Hangman
  include Display
  def initialize
    puts 'Welcome to hangman!'
  end

  def start_game
    case prompt_load_save
    when 1
      load_save
    when 2
      Game.new
    end
    start_game if play_again
    puts 'Thanks for playing!'

  end

  def load_save
    @saves = Dir['./saves/*'].map { |name| name[8..-1] }
    JSON.load_file(select_save, create_additions: true)
  end
end

test = Hangman.new
test.start_game