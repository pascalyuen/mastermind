# frozen_string_literal: true

require_relative 'display'

# game logic for mastermind
module GameLogic
  include Display

  attr_reader :both_correct_arr
  attr_accessor :computer_memory

  AVAILABLE_NUMBERS = Array(1..6)
  NUMBER_OF_ROUNDS = 12

  def save_input
    input = gets.chomp
    until input.length == 4 && input.split('').map(&:to_i).all? { |n| n.between?(1, 6) }
      puts "#{invalid_input}. #{enter_guess}"
      input = gets.chomp
    end

    input.split('').map(&:to_i)
  end

  private

  def generate_random(num)
    num == 1 ? AVAILABLE_NUMBERS.sample(1)[0] : AVAILABLE_NUMBERS.sample(num)
  end

  def player_guess
    save_input
  end

  def round_codemaker(guess, answer, round_number)
    puts '' if round_number == 1
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
    @computer_memory = []
    # Print the guess
    print guess
    4.times { print ' ' }
    # Print the feedback
    count_both_correct(guess, secret)
    count_correct_color(guess, secret)
    puts ''
  end

  # Check how many pegs are the correct color and correct position
  def count_both_correct(guess, answer)
    both_correct = 0
    @both_correct_arr = []
    guess.each_with_index do |e, i|
      if e == answer[i]
        both_correct += 1
        @both_correct_arr.push(e)
      end
    end
    both_correct.times { print '⚫' }
  end

  # Check how many pegs are the correct color and incorrect position
  def count_correct_color(guess, answer)
    correct_color_arr = []
    guess.each do |e|
      next if @both_correct_arr.include?(e)
      next if correct_color_arr.include?(e)

      correct_color_arr.push(e) if answer.include?(e)
    end
    correct_color_arr -= @both_correct_arr
    @computer_memory = @computer_memory.concat(correct_color_arr).uniq
    correct_color_arr.count.times { print '⚪' }
    puts ''
  end

  def computer_random(sequence, answer)
    if sequence.empty?
      generate_random(4)
    else
      keep_correct_match(sequence, answer)
    end
  end

  def keep_correct_match(sequence, answer)
    sequence.each_with_index do |e, i|
      next if e == answer[i]

      @tried[i].push(e)
      combined = @both_correct_arr.concat(@computer_memory).uniq
      # @tried[i].sort.count >= combined.sort.count: no more correct color but wrong position pegs to try
      sequence[i] = if @computer_memory.empty? || @tried[i].sort.count >= combined.sort.count
                      (AVAILABLE_NUMBERS - @tried[i]).sample
                    else
                      (combined - @tried[i]).sample
                    end
    end
    sequence
  end
end
