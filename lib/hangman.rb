# frozen_string_literal: true

require_relative 'display'
require_relative 'game'
require 'json'

# Manages loading saves and creating games
class Hangman
  include Display
  def initialize
    puts 'Welcome to hangman!'
    start_game
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

Hangman.new
