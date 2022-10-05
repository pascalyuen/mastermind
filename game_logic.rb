# frozen_string_literal: true

require_relative 'display'

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

    input.split('').map(&:to_i)
  end

  private

  def generate_random
    AVAILABLE_NUMBERS.sample(4)
  end

  def cross_check(sequence)
    if save_input == sequence
      correct_guess
    else
      puts 'Wrong guess'
    end
  end
end
