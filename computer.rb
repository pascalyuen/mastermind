# frozen_string_literal: true

require_relative 'game_logic'

# Class for the computer player
class Computer
  include GameLogic

  attr_reader :secret_pattern

  def initialize
    @secret_pattern = generate_random
  end
end
