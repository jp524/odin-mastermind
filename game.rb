# frozen_string_literal: false

# Compares a secret code and a guess and provides feedback
module Feedback
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
  include Feedback

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

  def display_code
    @secret_combination
  end
end

# Starts the initial round for the computer to play as the Codebreaker
class CodebreakerComputer
  include Feedback

  def initialize(code)
    @code = code
    @turn = 0
    @guess = [1, 1, 2, 2]
    @all_solutions = [1, 2, 3, 4, 5, 6, 7, 8].repeated_permutation(4).to_a
  end

  def check_guess_computer
    check_guess(@code, @guess)
  end

  def filter_solutions(pegs)
    @all_solutions.reject! do |possible_solution|
      pegs == check_guess(@code, possible_solution)
    end
  end

  def play
    puts "Number of possble solutions : #{@all_solutions.length}"
    while @turn < 12
      @turn += 1
      puts "\nNumber of turns: #{@turn}\n\n"
      puts "Code : #{@code}"
      puts "Computer guess : #{@guess}"
      pegs = check_guess_computer
      if pegs[:red] == 4
        puts "\nThe computer guessed your code in #{@turn} turns!"
        break
      end
      filter_solutions(pegs)
      @guess = @all_solutions[0]
      puts "Number of possble solutions : #{@all_solutions.length}"
    end
  end
end

# Starts game when player is the codemaker. After the code is set, the CodebreakerComputer class is called
class CodemakerPlayer
  def play
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
end

# Starts game when player is the codebreaker. The game runs until the code is guessed or until 12 turns are up
class CodebreakerPlayer
  def initialize
    @turn = 0
    @code = CodemakerComputer.new
    puts "You have 12 turns to guess the secret combination.\n\n"
    puts "Feedback of 'red peg' means a number was in the correct spot."
    puts "'White peg' means a number is part of the code but not in the correct spot."
  end

  def play
    while @turn < 12
      puts "\nNumber of turns: #{@turn + 1}\n\n"
      guess = Input.new
      guess.input_prompt
      if guess.valid_input? == true
        @turn += 1
        pegs = @code.check_guess_player(guess.convert_to_i)
        if pegs[:red] == 4
          puts "\nYou guessed correctly in #{@turn} turns!"
          break
        end
        puts "Red peg: #{pegs[:red]}. White peg: #{pegs[:white]}"
      else
        puts "\nInvalid input. Try again.\n"
      end
    end

    puts "\nYou used all 12 turns. Try again!. The code was #{code.display_code}." if @turn == 12
  end
end

# Starts game
class RunGame
  role = ''

  while role != '1' && role != '2'
    puts "\nWelcome to Mastermind! Would you like to be the Codemaker (1) or Codebreaker (2)? Type 1 or 2:\n"
    role = gets.chomp
    case role
    when '1'
      game = CodemakerPlayer.new
      game.play
    when '2'
      game = CodebreakerPlayer.new
      game.play
    else
      puts 'Invalid input.'
    end
  end
end

RunGame.new
