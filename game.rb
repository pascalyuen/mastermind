# frozen_string_literal: true

require_relative 'display'
require_relative 'game_logic'

# Class for starting and playing the game
class Game
  include Display
  include GameLogic

  attr_accessor :tried

  def game_intro
    display_intro

    input = gets.chomp
    new_game(input) if %w[1 2].include?(input)
  end

  def new_game(input)
    codemaker if input == '1'
    codebreaker if input == '2'
  end

  # Player chooses to be the codemaker
  def codemaker
    round = 1
    puts enter_guess
    player_answer = save_input
    computer_guess = []
    @tried = Array.new(4) { [] }
    while round <= 12
      computer_guess = computer_random(computer_guess, player_answer)
      break if round_codemaker(computer_guess, player_answer, round)

      round += 1
    end
    # End of 12th round
    puts wrong_guess(player_answer) if round > 12
  end

  # Player chooses to be the codebreaker
  def codebreaker
    round = 1
    computer_answer = generate_random(4)
    while round <= 12
      break if round_codebreaker(computer_answer, round)

      round += 1
    end
    # End of 12th round
    puts wrong_guess(computer_answer) if round > 12
  end
end
