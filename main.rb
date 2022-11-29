# frozen_string_literal: true

require 'bundler'
Bundler.require(:default)
require_relative 'game'

game = Game.new
game.game_intro
