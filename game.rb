# class Codebreaker

# end

class Codemaker
  def initialize
    @colours = [1, 2, 3, 4, 5, 6, 7, 8]
    @secret_combination = []
    @colour_legend = {  1 => 'black',
                        2 => 'white',
                        3 => 'purple',
                        4 => 'orange',
                        5 => 'green',
                        6 => 'yellow',
                        7 => 'blue',
                        8 => 'magenta' }
    generate_code
  end

  def generate_code
    4.times do
      @secret_combination.push(@colours.sample)
    end
  end

  def display_code
    @secret_combination.each do |colour|
      print "#{@colour_legend[colour]} "
    end
  end
end

# class RunGame
#   @keys = %w[white red]
# end

code = Codemaker.new
code.display_code
