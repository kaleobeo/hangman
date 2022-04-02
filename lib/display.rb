# frozen_string_literal: true

module Display
  def get_save_name
    puts 'What would you like to call this game?'
    out = gets.chomp
    get_save_name if out.include?('/') || out.length > 25

    out
  end
end