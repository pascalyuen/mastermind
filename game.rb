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
    if input == '1'
       new_game
    else
      return
    end
  end

  def new_game
    puts enter_guess
    save_input
    # computer = Computer.new
    # puts cross_check(secret_pattern)
    # puts computer.secret_pattern
  end
end
