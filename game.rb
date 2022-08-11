# Gets user input to try to break the secret code set by the Codemaker
class Codebreaker
  attr_reader :input

  def initialize
    @numbers = [1, 2, 3, 4, 5, 6, 7, 8]
    @guess = []
    @input = ''
  end

  def input_prompt
    puts "Choose four numbers out of the following eight options: 1, 2, 3, 4, 5, 6, 7, 8\n"
    @input = gets.chomp.split(' ')
  end

  def valid_input?
    return false if @input.length != 4

    @input.each do |i|
      return false unless @numbers.include?(i.to_i)
    end
    true
  end

  def convert_to_i
    @input.map!(&:to_i)
  end
end

# Generates the secret code and verifies guesses made by the Codebreaker
class Codemaker
  def initialize
    @numbers = [1, 2, 3, 4, 5, 6, 7, 8]
    @secret_combination = []
    generate_code
  end

  def generate_code
    4.times do
      @secret_combination.push(@numbers.sample)
    end
  end

  def correct_guess?(guess)
    return true if guess == @secret_combination
  end

  def check_guess(guess)
    new_combination = @secret_combination.dup
    guess.each_with_index do |number, i|
      if number == @secret_combination[i]
        puts 'red peg'
        new_combination[i] = 'X'
      end
    end
    guess.each do |number|
      puts 'white peg' if new_combination.include?(number)
    end
  end

  private

  def display_code
    p @secret_combination
  end
end

class RunGame
  turn = 0
  code = Codemaker.new
  puts "\nWelcome to Mastermind!\n\n"
  puts "You have 12 turns to guess the secret combination.\n\n"
  puts "Feedback of 'red peg' means a number was in the correct spot."
  puts "'White peg' means a number is part of the code but not in the correct spot."

  while turn < 12
    puts "\nNumber of turns: #{turn}\n\n"
    guess = Codebreaker.new
    guess.input_prompt
    if guess.valid_input? == true
      turn += 1
      if code.correct_guess?(guess.convert_to_i) == true
        puts "\nYou guessed correctly in #{turn} turns!"
        break
      else
        code.check_guess(guess.convert_to_i)
      end
    else
      puts "\nInvalid input. Try again.\n"
      puts "\n\nNumber of turns: #{turn}\n\n"
      guess.input_prompt
    end
  end
end

RunGame.new
