# frozen_string_literal: true

require 'colorize'

# Module for the display dialogues
module Display
  def display_intro
    puts "Welcome to the game of Mastermind\n\n"
    puts '*** How to play ***'
    puts "The available numbers are #{'1'.colorize(:red)} #{'2'.colorize(:green)} "\
          "#{'3'.colorize(:blue)} #{'4'.colorize(:yellow)} #{'5'.colorize(:magenta)} #{'6'.colorize(:cyan)}"
    puts 'The codebreaker has 12 turns to guess the secret code.'
    puts 'Feedback is provided after each turn.'
    puts '⚫ indicates the existence of a code peg placed in both correct color and position.'
    puts '⚪ indicates the existence of a correct color code peg placed in the wrong position.'
    puts '--- Press 1 to be the codemaker ---'
    puts '--- Press 2 to be the codebreaker ---'
  end

  def enter_code
    'Enter a 4-digit code'
  end

  def enter_guess
    'Enter a 4-digit number as the code'
  end

  def invalid_input
    'Invalid input'
  end

  def correct_guess(answer)
    "You guessed it right! Congratulations. The code is #{answer}."
  end

  def wrong_guess(answer)
    "Wrong guess. Game over! The code is #{answer}."
  end
end
