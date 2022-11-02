# frozen_string_literal: true

require_relative 'display'
require 'pry'

# game logic for mastermind
module GameLogic
  include Display

  AVAILABLE_NUMBERS = Array(1..6)
  NUMBER_OF_ROUNDS = 12
  @@both_correct_index = []

  def save_input
    input = gets.chomp
    until input.length == 4 && input.split('').map(&:to_i).all? { |n| n.between?(1, 6) }
      puts "#{invalid_input}. #{enter_guess}"
      input = gets.chomp
    end

    input.split('').map(&:to_i)
  end

  def colorize_input(array)
    array.map do |n|
      case n
      when 1 then '1'.red
      when 2 then '2'.green
      when 3 then '3'.blue
      when 4 then '4'.yellow
      when 5 then '5'.magenta
      when 6 then '6'.cyan
      end
    end
  end

  private

  def generate_random
    AVAILABLE_NUMBERS.sample(4)
  end

  def cross_check(sequence, index)
    guess = save_input
    # If pegs in the correct color and correct position, break out of the loop
    if guess == sequence
      puts correct_guess
      throw :cross_check
    # If it's the end of the 12th round, break out of the loop
    elsif index == NUMBER_OF_ROUNDS
      puts game_over
      puts "The code is #{sequence}."
      throw :cross_check
    else
      # Print feedback
      feedback(guess, sequence)
    end
  end

  # Print the guess and black/white pegs as feedback
  def feedback(codebreaker, secret)
    # Print the guess
    colorized = colorize_input(codebreaker)
    colorized.each { |n| print n }
    4.times { print ' ' }
    # Print the feedback
    count_both_correct(codebreaker, secret)
    count_correct_color(codebreaker, secret)
    puts ''
  end

  # Check how many pegs are the correct color and correct position
  def count_both_correct(codebreaker, secret)
    both_correct = 0
    codebreaker.each_with_index do |element, i|
      if element == secret[i]
        both_correct += 1
        @@both_correct_index.push(i)
      end
    end
    both_correct.times { print '⚫' }
  end

  # Check how many pegs are the correct color and incorrect position
  def count_correct_color(codebreaker, secret)
    correct_color = 0
    codebreaker.each_with_index do |element, i|
      next if @@both_correct_index.include?(i)

      correct_color += 1 if secret.include?(element)
    end
    correct_color.times { print '⚪' }
    @@both_correct_index.clear
  end
end

# Tesintg

# Answer
# 1564

# Only one correct color and position, other 3 all wrong
# 1222

# Two correct
# 1522

# Three correct
# 1562

# All correct
# 1564

# One correct color and position, other 3 correct color but wrong position
# 1645

# Two correct color and position, other 2 correct color but wrong position
# 1546

# Three correct color and position, last one correct color and wrong position
# 1561

# Other cases
# 5555
# 0000
