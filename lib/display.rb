# frozen_string_literal: true

# Manages interface with player
module Display
  def get_save_name
    puts 'What would you like to call this game?'
    out = gets.chomp
    out = get_save_name if out.include?('/') || out.length > 25

    out
  end

  def display_hidden_word
    puts @solution_hidden.join(' ')
  end

  def correct_guess
    puts 'Your guess was correct, amazing!'
  end

  def incorrect_guess
    puts 'Looks like your guess wasn\'t right, try again!'
  end

  def user_action_choice
    puts 'Please enter \'1\' to guess a letter, \'2\' to guess a word, \'3\' to save and exit the game.'
    out = gets.chomp
    unless %w[1 2 3].include?(out)
      input_error
      out = user_action_choice
    end

    out
  end

  def prompt_load_save
    puts 'Please enter \'1\' to load from save, or \'2\' to make a new game.'
    out = gets.chomp.to_i

    out = prompt_load_save unless out.positive?

    out
  end

  def select_save
    puts 'Please enter the number of the game you would like to play.', 'Your saves:'
    @saves.each_with_index { |save, idx| puts "#{idx + 1}: #{save}" }

    out = gets.chomp.to_i
    list_saves unless out.positive? && out.to_s.length == 1

    "./saves/#{@saves[out - 1]}"
  end

  def play_again
    puts 'Would you like to play again? (y/n)'
    out = gets.chomp
    unless %w[y n].include?(out)
      input_error
      play_again
    end
    return true if out == 'y'

    false
  end

  def game_lose
    puts 'Dang, looks like you lost this game.'
  end

  def game_win
    puts 'You got the word, amazing!'
  end

  def ask_for_guess
    puts 'Please enter a word to guess. (It will be between 5 and 12 letters)'
    out = gets.chomp
    if out.include?(' ')
      input_error
      out = ask_for_guess
    end

    out
  end

  def ask_for_letter
    puts 'Please input one letter to guess.'
    out = gets.chomp
    unless ('a'..'z').include?(out)
      input_error
      out = ask_for_letter
    end
    out
  end

  def input_error
    puts 'Sorry, looks like you may have inputted something improperly, please try again.'
  end
end
