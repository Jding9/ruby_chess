require 'stringio'
require './lib/chess'
require './lib/game_functions'
require './lib/moves'

describe 'Game' do
    describe 'check for check' do
        game = Game.new()

        it "checks to see if a check status is present" do

        game.board = [
            [$w_rook, $w_knig, $w_bish, $w_quee, $w_king, $w_bish, $w_knig, $w_rook],  
            [$w_pawn, $w_pawn, $w_pawn, $w_pawn, ' ', $w_pawn, $w_pawn, $w_pawn],                      
            [' ',' ',' ',$b_knig,' ',' ',' ',' '],
            [' ',' ',' ',' ',' ',' ',' ',' '],
            [' ',' ',' ',' ',' ',' ',' ',' '],
            [' ',' ',' ',' ',' ',' ',' ',' '],
            [$b_pawn, $b_pawn, $b_pawn, $b_pawn, $b_pawn, $b_pawn, $b_pawn, $b_pawn],
            [$b_rook, $b_knig, $b_bish, $b_quee, $b_king, $b_bish, $b_knig, $b_rook]
        ]

        game.print_board

        expect(game.check_for_check).to be true
        end

    end
end
