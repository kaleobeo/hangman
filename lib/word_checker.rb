# frozen_string_literal: true

module WordChecker
  def set_solution_variables
    @solution_split = @solution.split('')
    @solution_hidden = Array.new(@solution.length, '_')
  end

  def check_letter(guess)
    @solution.include?(guess) ? @hits.push(guess) : @misses.push(guess)
    @solution_split.each_with_index do |letter, index|
      @solution_hidden[index] = letter if letter.upcase == guess.upcase
    end
    @solution_hidden
  end

  def correct_word?(guess)
    @solution.downcase == guess.downcase
  end
end