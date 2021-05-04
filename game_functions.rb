module Board_Checks

    def print_board
        # need to add the a-h and 1 to 8 markings on the outside of these
        p [" ", "a", "b", "c", "d", "e", "f", "g", "h"]
        p ["8"].concat(@board[7])
        p ["7"].concat(@board[6])
        p ["6"].concat(@board[5])
        p ["5"].concat(@board[4])
        p ["4"].concat(@board[3])
        p ["3"].concat(@board[2])
        p ["2"].concat(@board[1])
        p ["1"].concat(@board[0])
    end

    # checks for remaining pieces that a player can move
    def remaining_pieces_check(turn = @turn)

        if turn == 1
            pieces = @board.flatten.uniq.select { |n| @w_pieces.include?(n)}
            pieces.map { |piece| @names_of_pieces[piece]}
        else
            pieces = @board.flatten.uniq.select { |n| @b_pieces.include?(n)}
            pieces.map { |piece| @names_of_pieces[piece]}
        end
    end

    def position_converter(position)
        row = position[0]
        column = position[1]
        letters = {
            0 => "a",
            1 => "b",
            2 => "c",
            3 => "d",
            4 => "e",
            5 => "f",
            6 => "g",
            7 => "h"
        }
        numbers = {
            0 => "1",
            1 => "2",
            2 => "3",
            3 => "4",
            4 => "5",
            5 => "6",
            6 => "7",
            7 => "8"
        }

        return letters[column] + numbers[row]
    end

    # takes in a string like B1 and converts it into a position on the board - in this case [1, 2]
    def invert_position_converter(letternumber)
        position = letternumber.split("")
        letters = {
            "a" => 0,
            "b" => 1,
            "c" => 2,
            "d" => 3,
            "e" => 4,
            "f" => 5,
            "g" => 6,
            "h" => 7
        }
        numbers = {
            "1" => 0,
            "2" => 1,
            "3" => 2,
            "4" => 3,
            "5" => 4,
            "6" => 5,
            "7" => 6,
            "8" => 7
        }

        # it gets converted back into row then column, which is number then letter first
        new_position = [numbers[position[1]], letters[position[0]]]
        position = new_position
        return position

    end

    # takes in 
    def update_board(starting_position, ending_position, piece)
        starting_row = starting_position[0]
        starting_col = starting_position[1]
        ending_row = ending_position[0]
        ending_col = ending_position[1]
        if @board[ending_row][ending_col] != " "
            @graveyard << @board[ending_row][ending_col]
        end
        @board[ending_row][ending_col] = piece
        @board[starting_row][starting_col] = " "
    end

    # checks for a "check" condition and a "checkmate condition" after each move
    def check_for_check(board = @board)

        # takes in all the positions that the king can move

        # takes in all the positions that the enemy pieces can move
        # king cannot move into an area where the enemy piece can move next turn

        # if a check is already present
        # takes in all the positions that the player's pieces can move to defend the king if king is already stuck

        
    end

end