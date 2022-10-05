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
    new_game if input == '1'
  end

  def new_game
    puts enter_guess
    computer = Computer.new
    cross_check(computer.secret_pattern)
  end
end
