class Codebreaker
  attr_reader :colour_legend

  def initialize
    @guess = []
    @input = ''
  end

  def input_prompt
    print "Choose four numbers out of the following eight options:\n"
    print "1, 2, 3, 4, 5, 6, 7, 8\n"
    print "For example: '1 8 7 7'.\n"
    @input = gets.chomp
  end

  def valid_input?
    array = @input.split(' ')
    return false if array.length != 4

    array.each do |i|
      # return false if [1, 2, 3, 4, 5, 6, 7, 8].include?(+i) == false
      p [1, 2, 3, 4, 5, 6, 7, 8].include?(i.to_i)
    end
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

  private

  def display_code
    p @secret_combination
  end
end

# class RunGame
#   @keys = %w[white red]
# end

# code = Codemaker.new
# code.display_code

guess = Codebreaker.new
guess.input_prompt
p guess.valid_input?
