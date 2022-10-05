# frozen_string_literal: true

require 'colorize'

# Module for the display dialogues
module Display
  def display_intro
    puts 'Welcome to the game of Mastermind\n\n'
    puts '*** How to play ***'
    puts "The available numbers are #{'1'.red} #{'2'.green} #{'3'.blue} #{'4'.yellow} "\
          "#{'5'.magenta} #{'6'.cyan} #{'7'.light_yellow} #{'8'.white}\n\n"
    puts '--- Press 1 to start ---'
  end

  def enter_guess
    'nter a 4-digit number guess'
  end

  def invalid_input
    'Invalid input'
  end

  def correct_guess
    'You guessed it right!'
  end
end