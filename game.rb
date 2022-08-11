class Codebreaker
  attr_reader :input

  def initialize
    @numbers = [1, 2, 3, 4, 5, 6, 7, 8]
    @guess = []
    @input = ''
  end

  def input_prompt
    puts "Choose four numbers out of the following eight options:\n"
    puts "1, 2, 3, 4, 5, 6, 7, 8\n"
    puts "For example: '1 8 7 7'.\n"
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
    return true if guess.convert_to_i == @secret_combination
  end

  private

  def display_code
    p @secret_combination
  end
end

class RunGame
  turn = 0
  code = Codemaker.new

  while turn < 12
    puts "Number of turns: #{turn}\n\n"
    guess = Codebreaker.new
    guess.input_prompt
    if guess.valid_input? == true
      turn += 1
      if code.correct_guess?(guess) == true
        puts "\nYou guess correctly in #{turn} turns!"
        break
      end
    else
      puts "\nInvalid input. Try again.\n"
      puts "Number of turns: #{turn}\n\n"
      guess.input_prompt
    end
  end
end

RunGame.new
