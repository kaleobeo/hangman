# frozen_string_literal: true

module Display
  def get_save_name
    puts 'What would you like to call this game?'
    out = gets.chomp
    get_save_name if out.include?('/') || out.length > 25

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
      user_action_choice
    end

    out
  end

  def ask_for_letter
    puts 'Please input one letter to guess.'
    out = gets.chomp
    unless ('a'..'z').include?(out)
      input_error
      ask_for_guess
    end
    out
  end

  def input_error
    puts 'Sorry, looks like you may have inputted something improperly, please try again.'
  end
end