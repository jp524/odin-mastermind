# frozen_string_literal: false

# Compares a secret code and a guess and provides feedback
module Verification
  def check_guess(code, guess)
    pegs = { red: 0, white: 0 }
    code.each_with_index do |number, i|
      if number == guess[i]
        pegs[:red] += 1
        next
      elsif guess.include?(number)
        pegs[:white] += 1
      end
    end
    pegs
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

  def check_guess_player(guess)
    check_guess(@secret_combination, guess)
  end

  def correct_guess_player?(guess)
    correct_guess?(@secret_combination, guess)
  end

  def display_code
    @secret_combination
  end
end

# Starts the initial round for the computer to play as the Codebreaker
class CodebreakerComputer
  attr_reader :all_solutions

  include Verification
  def initialize(code)
    @code = code
    @turn = 0
    @guess = [1, 1, 2, 2]
    @all_solutions = [1, 2, 3, 4, 5, 6, 7, 8].repeated_permutation(4).to_a
  end

  def check_guess_computer
    check_guess(@code, @guess)
  end

  def correct_guess_computer?
    correct_guess?(@code, @guess)
  end

  def play
    # while @turn < 12
      puts "\nNumber of turns: #{@turn}\n\n"
      # @turn += 1
      if correct_guess_computer? == true
        puts "\nThe computer guessed your code in #{@turn} turns!"
        # break
      else
        puts check_guess_computer
      end
    # end
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
  computer = CodebreakerComputer.new(code.convert_to_i)
  computer.play
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
      if code.correct_guess_player?(guess.convert_to_i) == true
        puts "\nYou guessed correctly in #{turn} turns!"
        break
      else
        pegs = code.check_guess_player(guess.convert_to_i)
        puts "Red peg: #{pegs[:red]}. White peg: #{pegs[:white]}"
      end
    else
      puts "\nInvalid input. Try again.\n"
      puts "\n\nNumber of turns: #{turn}\n\n"
      guess.input_prompt
    end
  end

  puts "\nYou used all 12 turns. Try again!. The code was #{code.display_code}." if turn == 12
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
