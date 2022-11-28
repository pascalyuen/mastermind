# frozen_string_literal: true

require_relative 'game'

game = Game.new
game.game_intro

# Next step
# If the computer has guessed the right color but the wrong position,
# its next guess will need to include that color somewhere
