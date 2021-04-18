# This is a program where two players can play chess against each other in a console

require "pry"

class Game

    attr_accessor :board, :turn

    def initialize

        b_rook = "\u265C" 
        b_knig = "\u265E"
        b_bish = "\u265D"
        b_quee = "\u265B"
        b_king = "\u265A"
        b_pawn = "\u265F"

        w_rook = "\u2656"
        w_knig = "\u2658"
        w_bish = "\u2657"
        w_quee = "\u2655"
        w_king = "\u2654"
        w_pawn = "\u2659"

        @board = [
            [b_rook, b_knig, b_bish, b_quee, b_king, b_bish, b_knig, b_rook],
            [b_pawn, b_pawn, b_pawn, b_pawn, b_pawn, b_pawn, b_pawn, b_pawn],
            [' ',' ',' ',' ',' ',' ',' ',' '],
            [' ',' ',' ',' ',' ',' ',' ',' '],
            [' ',' ',' ',' ',' ',' ',' ',' '],
            [' ',' ',' ',' ',' ',' ',' ',' '],
            [w_pawn, w_pawn, w_pawn, w_pawn, w_pawn, w_pawn, w_pawn, w_pawn],
            [w_rook, w_knig, w_bish, w_quee, w_king, w_bish, w_knig, w_rook]                        
        ]

        # Turn 1 is for the player "White" and Turn 2 is for player "Black"

        w_pieces = [w_rook, w_knig, w_bish, w_quee, w_king, w_pawn] 
        b_pieces = [b_rook, b_knig, b_bish, b_quee, b_king, b_pawn] 

        @turn = 1

        def print_board
            p @board[0]
            p @board[1]
            p @board[2]
            p @board[3]
            p @board[4]
            p @board[5]
            p @board[6]
            p @board[7]
        end

    end

end

module Moves

    def rook_moves(row, column)

    end

end

game = Game.new()