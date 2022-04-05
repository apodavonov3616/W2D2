class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  
  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = @secret_word.split("").map { |ele| "_" }
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    if @attempted_chars.include?(char)
      return true
    else
      return false
    end
  end

  def get_matching_indices(char)
    indecis= []
    @secret_word.each_char.with_index do |ele, idx|
      if char == ele
        indecis << idx
      end
    end
    indecis
  end

  def fill_indices(char, array)
    @guess_word.each_with_index do |ele, idx|
      if array.include?(idx)
        @guess_word[idx] = char
      end
    end
    @guess_word
  end

  def try_guess(char)
    if already_attempted?(char)
      p "that has already been attempted"
      return false
    end

    @attempted_chars << char

    indexes = get_matching_indices(char)
    if indexes != []
      fill_indices(char, indexes)
    else
      @remaining_incorrect_guesses -=1
    end
    true
  end

  def ask_user_for_guess
    p "Enter a char:"
    input = gets.chomp
    try_guess(input)
  end

  def win?
    if @guess_word == @secret_word.split('')
      p "WIN"
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      p "LOSE"
      return true
    else
      return false
    end
  end

  def game_over?
    if win? || lose?
      p @secret_word
      return true
    else 
      return false
    end
  end
end
