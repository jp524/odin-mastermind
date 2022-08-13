# Odin Mastermind

Built as part of [The Odin Project's Full Stack Ruby on Rails](https://www.theodinproject.com/paths/full-stack-ruby-on-rails?) curriculum: [Ruby course](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby).

This is a command line game inspired by Mastermind. Run `ruby game.rb` to start!

The player can choose to be the codemaker or codebreaker. The other role will be assumed by the computer.

The computer's codebreaker algorithm is based on the strategy developped by Swaszek. This guarantees that the computer will break the code within a certain number of attempts.

## Rules
* The codebreaker has 12 attempts to break the code
* The code is composed of four numbers from the list [1, 2, 3, 4, 5, 6, 7, 8]
* Duplicable numbers are allowed in the code
* If the player is the codebreaker, the interpretation of keys pegs is as follow:
  *  'Red peg' means a number was in the correct spot
  * 'White peg' means a number is part of the code but not in the correct spot

## Techniques Implemented
* Designed with object-oriented programming mindset
* Use of different classes and modules
* Added top-level documentation for classes and modules
* Limited use of attribute readers and accessors to keep information contained within classes

## Improvement Ideas
* Refactor code to combine logic inherent to CodebreakerPlayer and CodebreakerComputer classes
* Refactor code to use private methods when possible