# frozen_string_literal: true

require_relative 'display'
require_relative 'game_logic'
require_relative 'computer'

# Class for starting and playing the game
class Game
  include Display
  include GameLogic

  def game_intro
    display_intro

    input = gets.chomp
    new_game_codemaker if input == '1'
    new_game_codebreaker if input == '2'
  end

  # Player chooses to be the codemaker
  def new_game_codemaker
    puts "#{enter_guess} as the code"
    player_code = save_input
    catch(:cross_check) do
      (1..12).each do |i|
        puts "Round #{i}. The computer guesses #{computer_guessing_algo(player_code, i)}"
      end
    end
  end

  # Player chooses to be the codebreaker
  def new_game_codebreaker
    catch(:cross_check) do
      (1..12).each do |i|
        puts "Round #{i}. #{enter_guess}"
        cross_check(player_guess, generate_random, i)
      end
    end
  end
end
