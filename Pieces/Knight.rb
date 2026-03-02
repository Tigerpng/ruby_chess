require_relative "Piece"

class Knight < Piece
  def fen_symbol
    "n"
  end

  def get_all_moves(board)
    temp_moves = [
      [@position_row + 2, @position_col + 1],
      [@position_row + 2, @position_col - 1],
      [@position_row - 2, @position_col + 1],
      [@position_row - 2, @position_col - 1],
      [@position_row + 1, @position_col + 2],
      [@position_row - 1, @position_col + 2],
      [@position_row + 1, @position_col - 2],
      [@position_row - 1, @position_col - 2],
    ]
    moves = []
    temp_moves.each do |move|
      if self.check_move_valid(board, move)
        moves.append move
      end
    end
    moves
  end

  def check_move_valid(board, move)
    if !self.board_index_valid?(move)
      return false
    end
    if board[move[0]][move[1]] == 0
         return true
    end
    if board[move[0]][move[1]].color == color
        return false
    else
        return true
    end
  end
end
