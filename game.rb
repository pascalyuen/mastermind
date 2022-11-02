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

  def new_game_codemaker
    # sample
  end

  def new_game_codebreaker
    # cross_check(computer.secret_pattern)
    catch(:cross_check) do
      (1..12).each do |i|
        puts "Round #{i}. #{enter_guess}"
        # cross_check(generate_random, i)
        cross_check([1, 5, 6, 4], i)
      end
    end
  end
end
