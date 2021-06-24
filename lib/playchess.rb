
require "pry"
require_relative "chess.rb"
require_relative "moves.rb"
require_relative "game_functions.rb"

game = Game.new()

game.check_for_check

=begin
until game.check_for_checkmate
    game.play
end
=end