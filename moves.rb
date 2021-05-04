module Moves

    # checks if a potential move is valid (i.e. on the board and available to move to that position)
    def valid_move?(position)
        row = position[0]
        column = position[1]
        if row > 7 || row < 0 || column > 7 || column < 0
            return false
        else
            if turn == 1
                !@w_pieces.include?(@board[row][column])
            else
                !@b_pieces.include?(@board[row][column])
            end
        end
    end

    #returns all available positions that a selected rook can move
    def possible_moves(starting_position, actual_piece, turn = @turn)
        moves = []
        row = starting_position[0]
        column = starting_position[1]


        # moves available for white pawns
        if actual_piece == $w_pawn
            potential_moves = []
            # if the white pawn is in its original spot, then it can move two spots or one spot
            if row == 1
                potential_moves << [row+1, column]
                potential_moves << [row+2, column]
            else
                potential_moves << [row+1, column]
            end

            # can take black pieces
            potential_moves << [row+1, column+1] if @b_pieces.include?(@board[row+1, column+1])
            potential_mvoes << [row+1, column-1] if @b_pieces.include?(@board[row+1, column-1])

            potential_moves.select { |pos| valid_move?(pos)}
            
            return potential_moves
        end 

        # moves available for 
        if actual_piece == $b_pawn
        end

        # moves available for rooks
        if actual_piece == $w_rook || actual_piece == $b_rook
            for r in row..7 do
                if on_board?(row + 1, column)
                    test_spot = @board[row + 1][column]
                    if turn == 1
                        if w_pieces.include(test_spot)
                            break
                        elsif b_pieces.include(test_spot)
                            possible_moves << [row+1, column]
                            break
                        else
                            possible_moves << [row+1, column]
                        end
                    else
                        if b_pieces.include(test_spot)
                            break
                        elsif w_pieces.include(test_spot)
                            possible_moves << [row+1, column]
                            break
                        else
                            possible_moves << [row+1, column]
                        end
                    end
                end
            end
        end

        return moves

        #recursively finds every possible position below

        #recursively finds every possible position left

        #recursively finds every possible position right

    end

end