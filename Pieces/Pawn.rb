require_relative "Piece"

class Pawn < Piece
  def fen_symbol
    "p"
  end

  def get_all_moves(board)
    moves = []
    if color == :white
      move_direction = -1
      base_row = 6
    else
      move_direction = +1
      base_row = 1
    end
    move = [@position_row + (1 * move_direction), @position_col]
    unless Board.board_index_valid?(move)
      return []
    end
    if board[move[0]][move[1]] == 0
      moves.append move
    end
    if @position_row == base_row
      move = [@position_row + (2 * move_direction), @position_col]
      if board[move[0]][move[1]] == 0
        moves.append move
      end
    end
    capture_move = [@position_row + (1 * move_direction), @position_col + 1]
    if check_capeture_move(capture_move, board)
      moves.append capture_move
    end
    capture_move = [@position_row + (1 * move_direction), @position_col - 1]
    if check_capeture_move(capture_move, board)
      moves.append capture_move
    end
    return moves
  end

  def check_capeture_move(capture_move, board)
    if Board.board_index_valid?(capture_move)
      if board[capture_move[0]][capture_move[1]] != 0
        if board[capture_move[0]][capture_move[1]].color != color
          return true
        end
      end
    end
    return false
  end

end
