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
    new_game if input == '2'
  end

  def new_game
    # puts '⚫ ⚪'
    puts enter_guess
    computer = Computer.new
    # cross_check(computer.secret_pattern)
    cross_check([5, 4, 1, 6])
  end
end
