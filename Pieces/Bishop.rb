require_relative "Piece"

class Bishop < Piece
  def fen_symbol
    "b"
  end

  def get_all_moves(board)
    move = [@position_row, @position_col]
    moves = []
    (0..3).each do |direction|
      case direction
      when 0
        col_direction = 1
        row_direction = 1
      when 1
        col_direction = 1
        row_direction = -1
      when 2
        col_direction = -1
        row_direction = 1
      when 3
        col_direction = -1
        row_direction = -1
      end
      break_while = false
      move = [@position_row, @position_col]
      while !break_while
        move[0] += row_direction
        move[1] += col_direction
        if board_index_valid?(move)
          if board[move[0]][move[1]] != 0
            if board[move[0]][move[1]].color == color
              move[0] = move[0] - row_direction
              move[1] = move[1] - col_direction
            end
            break_while = true
          end
        moves.append move.clone
        else
          break_while = true
        end
      end
    end
    moves
  end
end