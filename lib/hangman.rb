class Hangman
  def save_game
    save_name = get_save_name
    @path = "./saves/#{save_name}.txt"
    File.open(@path, 'w') do |file|
      JSON.dump(self, file)
    end
  end
end