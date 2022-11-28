# frozen_string_literal: true

require_relative 'display'
require 'pry-byebug'

# game logic for mastermind
module GameLogic
  include Display

  AVAILABLE_NUMBERS = Array(1..6)
  NUMBER_OF_ROUNDS = 12
  @@both_correct_arr = []
  @@tried = Array.new(4) { Array.new }

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

  def generate_random(num)
    num == 1 ? AVAILABLE_NUMBERS.sample(1)[0] : AVAILABLE_NUMBERS.sample(num)
  end

  def player_guess
    save_input
  end

  def round_codemaker(guess, answer, round_number)
    puts "Round #{round_number}. The computer guesses #{guess}"
    cross_check(guess, answer)
  end

  def round_codebreaker(answer, round_number)
    puts "Round #{round_number}. #{enter_guess}"
    cross_check(player_guess, answer)
  end

  def cross_check(guess, answer)
    if guess == answer
      puts correct_guess(answer)
      true
    else
      # Print feedback
      feedback(guess, answer)
    end
  end

  # Print the guess and black/white pegs as feedback
  def feedback(guess, secret)
    # Print the guess
    colorized = colorize_input(guess)
    colorized.each { |e| print e }
    4.times { print ' ' }
    # Print the feedback
    count_both_correct(guess, secret)
    count_correct_color(guess, secret)
    puts ''
  end

  # Check how many pegs are the correct color and correct position
  def count_both_correct(guess, answer)
    both_correct = 0
    @@both_correct_arr.clear
    guess.each_with_index do |e, i|
      if e == answer[i]
        both_correct += 1
        @@both_correct_arr.push(e)
      end
    end
    both_correct.times { print '⚫' }
  end

  # Check how many pegs are the correct color and incorrect position
  def count_correct_color(guess, answer)
    correct_color_arr = []
    guess.each do |e|
      next if @@both_correct_arr.include?(e)
      next if correct_color_arr.include?(e)

      correct_color_arr.push(e) if answer.include?(e)
    end
    correct_color_arr.count.times { print '⚪' }
  end

  def computer_random(sequence, answer)
    if sequence.empty?
      generate_random(4)
    else
      switch_correct_color(sequence, answer)
      keep_correct_match(sequence, answer)
    end
  end

  def switch_correct_color(sequence, answer)
    
  end

  def keep_correct_match(sequence, answer)
    sequence.each_with_index do |e, i|
      next if e == answer[i]

      @@tried[i].push(e)
      puts "@@tried: #{@@tried}"
      sequence[i] = (AVAILABLE_NUMBERS - @@tried[i]).sample
    end
    sequence
  end
end
