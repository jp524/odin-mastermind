# frozen_string_literal: false

# Compares a secret code and a guess and provides feedback
module Verification
  def check_guess(code, guess)
    code.each_with_index do |number, i|
      if number == guess[i]
        puts 'red peg'
      elsif guess.include?(number)
        puts 'white peg'
      end
    end
  end

  def correct_guess?(code, guess)
    return true if guess == code
  end
end

# Gets user input to generate a code
class Input
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

# Generates a secret code and verifies guesses made by the CodebreakerPlayer
class CodemakerComputer
  attr_reader :secret_combination

  include Verification

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
end

# Starts the initial round for the computer to play as the Codebreaker
class CodebreakerComputer
  attr_reader :guess

  include Verification

  def initialize
    @turn = 0
    @guess = [1, 1, 2, 2]
  end
end

def codemaker_player
  code = Input.new
  code.input_prompt
  until code.valid_input?
    puts "\nInvalid input. Try again."
    code.input_prompt
  end
  puts "Code: #{code.convert_to_i}"
  play = CodebreakerComputer.new
  play.check_guess(code.convert_to_i, play.guess)
end

def codebreaker_player
  turn = 0
  code = CodemakerComputer.new
  puts "You have 12 turns to guess the secret combination.\n\n"
  puts "Feedback of 'red peg' means a number was in the correct spot."
  puts "'White peg' means a number is part of the code but not in the correct spot."

  while turn < 12
    puts "\nNumber of turns: #{turn}\n\n"
    guess = Input.new
    guess.input_prompt
    if guess.valid_input? == true
      turn += 1
      if code.correct_guess?(code.secret_combination, guess.convert_to_i) == true
        puts "\nYou guessed correctly in #{turn} turns!"
        break
      else
        code.check_guess(code.secret_combination, guess.convert_to_i)
      end
    else
      puts "\nInvalid input. Try again.\n"
      puts "\n\nNumber of turns: #{turn}\n\n"
      guess.input_prompt
    end
  end

  puts "\nYou used all 12 turns. Try again!" if turn == 12
end

# Starts game
class RunGame
  role = ''

  while role != '1' && role != '2'
    puts "\nWelcome to Mastermind! Would you like to be the Codemaker (1) or Codebreaker (2)? Type 1 or 2:\n"
    role = gets.chomp
    case role
    when '1'
      codemaker_player
    when '2'
      codebreaker_player
    else
      puts 'Invalid input.'
    end
  end
end

RunGame.new
