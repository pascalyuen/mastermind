# frozen_string_literal: true

require_relative 'display'
require_relative 'computer'

# game logic for mastermind
module GameLogic
  include Display

  AVAILABLE_NUMBERS = Array(1..8)

  def save_input
    input = gets.chomp
    until input.length == 4
      puts "#{invalid_input}. #{enter_guess}"
      input = gets.chomp
    end

    guess = input.split('').map(&:to_i)
    p guess
    p AVAILABLE_NUMBERS
  end

  def generate_random
    AVAILABLE_NUMBERS.sample(4)
  end

  private

  def cross_check(sequence)
    # return correct_guess if guess.sort == secret_pattern
    sequence
  end
end
