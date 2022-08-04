class RunGame
  @colour_legend = { 1 => 'black',
                     2 => 'white',
                     3 => 'purple',
                     4 => 'orange',
                     5 => 'green',
                     6 => 'yellow',
                     7 => 'blue',
                     8 => 'magenta' }
  @colours = [1, 2, 3, 4, 5, 6, 7, 8]
  @keys = %w[white red]
  @secret_combination = []

  def self.create_secret_combination
    4.times do
      @secret_combination.push(@colours.sample)
    end
  end

  create_secret_combination

  @secret_combination.each do |colour|
    print "#{@colour_legend[colour]} "
  end
end
