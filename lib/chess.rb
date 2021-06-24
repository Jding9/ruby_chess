# This is a program where two players can play chess against each other in a console

require "pry"
require_relative "moves.rb"
require_relative "game_functions.rb"

class Game

    include Moves
    include Board_Checks

    attr_accessor :board, :turn, :graveyard, :en_passant_piece
    attr_reader :w_pieces, :b_pieces, :names_of_pieces

    def initialize

        $b_rook = "\u265C" 
        $b_knig = "\u265E"
        $b_bish = "\u265D"
        $b_quee = "\u265B"
        $b_king = "\u265A"
        $b_pawn = "\u265F"

        $w_rook = "\u2656"
        $w_knig = "\u2658"
        $w_bish = "\u2657"
        $w_quee = "\u2655"
        $w_king = "\u2654"
        $w_pawn = "\u2659"

        @names_of_pieces = {
            $b_rook => "rook",
            $b_knig => "knight",
            $b_bish => "bishop",
            $b_quee => "queen",
            $b_king => "king",
            $b_pawn => "pawn",
    
            $w_rook => "rook",
            $w_knig => "knight",
            $w_bish => "bishop",
            $w_quee => "queen",
            $w_king => "king",
            $w_pawn => "pawn"
        }

        @board = [
            [$w_rook, $w_knig, $w_bish, $w_quee, $w_king, $w_bish, $w_knig, $w_rook],  
            [$w_pawn, $w_pawn, $w_pawn, $w_pawn, $w_pawn, $w_pawn, $w_pawn, $w_pawn],                      
            [' ',' ',' ',' ',' ',' ',' ',' '],
            [' ',' ',' ',' ',' ',' ',' ',' '],
            [' ',' ',' ',' ',' ',' ',' ',' '],
            [' ',' ',' ',' ',' ',' ',' ',' '],
            [$b_pawn, $b_pawn, $b_pawn, $b_pawn, $b_pawn, $b_pawn, $b_pawn, $b_pawn],
            [$b_rook, $b_knig, $b_bish, $b_quee, $b_king, $b_bish, $b_knig, $b_rook]
        ]

        # Turn 1 is for the player "White" and Turn 2 is for player "Black"
        # this breaks down the white pieces and the black pieces
        @w_pieces = [$w_rook, $w_knig, $w_bish, $w_quee, $w_king, $w_pawn] 
        @b_pieces = [$b_rook, $b_knig, $b_bish, $b_quee, $b_king, $b_pawn] 

        @graveyard = []

        @turn = 1

        # will record an en_passant_piece for one turn afterwards
        @en_passant_piece = []

    end

    # plays one turn of the game
    def play(board = @board)

        if check_for_checkmate
            puts "test"
        end

        remaining_pieces = remaining_pieces_check

        # if check for checkmate is true, then we should end the game and not continue with the game

        if @turn == 1
            puts "White's turn"
        else
            puts "Black's turn"
        end

        puts "Which piece would you like to move?"
        puts "You have the following pieces remaining: #{remaining_pieces}"

        answer = gets.chomp
        
        until remaining_pieces.include?(answer)
            puts "That's not an available piece"
            answer = gets.chomp
        end

        actual_piece = ""
        # turns the answer into the actual piece

        w_pieces_convert = {
            "rook" => $w_rook,
            "knight" => $w_knig,
            "bishop" => $w_bish,
            "queen" => $w_quee,
            "king" => $w_king,
            "pawn" => $w_pawn
        }

        b_pieces_convert = {
            "rook" => $b_rook,
            "knight" => $b_knig,
            "bishop" => $b_bish,
            "queen" => $b_quee,
            "king" => $b_king,
            "pawn" => $b_pawn
        }

        if turn == 1
            actual_piece = w_pieces_convert[answer]
        else
            actual_piece = b_pieces_convert[answer]
        end

        # returns an array of positions in [x, y] format that the player can choose from
        # starting_position there is only 1 position
        starting_position = []
        
        # if there is only one instance of the piece being on the board
        if @board.flatten.count(actual_piece) == 1
            for row in 0..7
                for column in 0..7
                    if @board[row][column] == actual_piece
                        starting_position << [row, column]
                    end
                end
            end
        # returns the starting position of all available selected pieces (for example, all rooks on the board)
        else
            for row in 0..7
                for column in 0..7
                    if @board[row][column] == actual_piece
                        starting_position << [row, column]
                    end
                end
            end
        end
        
        starting_position.each { |position| puts position_converter(position)}

        # asks the player for the starting piece if it's more than 1
        puts "Please select the starting position"
        selected_starting_position = gets.chomp.downcase
        until starting_position.include?(invert_position_converter(selected_starting_position))
            puts "Please select a valid starting position"
            selected_starting_position = gets.chomp.downcase
        end
        starting_position = invert_position_converter(selected_starting_position)
        
        # Provides list of possible moves
        moves = possible_moves(starting_position, actual_piece)
        puts "Where do you want to move your #{@names_of_pieces[actual_piece]}?"

        # Lets the player select a new piece and starting move if no moves are available
        if moves.count == 0
            puts "You will need to select a new piece as there are no moves available for that piece!"
            play
        else
            moves.each {|move| puts position_converter(move)}
        end
        
        # Player selects a valid move 
        selected_move = gets.chomp.downcase
        until moves.include?(invert_position_converter(selected_move))
            puts "Please select a valid move"
            selected_move = gets.chomp.downcase
        end

        # Looks at whether or not the selected move creates a check condition
        test_board = @board
        test_board = update_board(starting_position, invert_position_converter(selected_move), actual_piece, test_board)
        if check_for_check(test_board)
            puts "You can't do that, it would put your king in check!"
            play
        end

        @board = update_board(starting_position, invert_position_converter(selected_move), actual_piece)

        # resets the en_passant_piece once it's available as a selection for the previous situation
        @en_passant_piece = []

        # if the piece moved was a black pawn or a white pawn and it was moved 2 steps, then an en-passant move is available for the next player
        if (invert_position_converter(selected_move)[0] - starting_position[0]).abs == 2 && (actual_piece == $w_pawn || actual_piece == $b_pawn)
            @en_passant_piece = selected_move
        end
        
        print_board

        if @turn == 1
            @turn = 2
        else
            @turn = 1
        end

    end

end