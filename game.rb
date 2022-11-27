# frozen_string_literal: true

require_relative 'display'
require_relative 'game_logic'

# Class for starting and playing the game
class Game
  include Display
  include GameLogic

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
    puts enter_guess
    round = 1
    player_answer = save_input
    while round <= 12
      round_codemaker(player_answer, round)
      round += 1
    end
  end

  # Player chooses to be the codebreaker
  def codebreaker
    round = 1
    # answer = generate_random(4)
    answer = [1, 2, 3, 4]
    while round <= 12
      break if round_codebreaker(answer, round)

      round += 1
    end
    # End of 12th round
    puts wrong_guess(answer) if round > 12
  end
end
