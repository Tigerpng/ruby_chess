require_relative "Piece"

class Rook < Piece
  def fen_symbol
    "r"
  end

  def get_all_moves(board)
    # need to refactor later
    moves = []
    col_index = @position_col
    while_done = false
    while col_index < 7 && !while_done
      col_index += 1
      if board[@position_row][col_index] != 0
        col_index -= 1
        while_done = true
      end
    end
    col_right_end = col_index
    while_done = false
    col_index = @position_col
    while col_index > 0 && !while_done
      col_index -= 1
      if board[@position_row][col_index] != 0
        col_index += 1
        while_done = true
      end
    end
    col_left_end = col_index
    row_index = @position_row
    while_done = false
    while row_index < 7 && !while_done
      row_index += 1
      if board[row_index][@position_col] != 0
        row_index -= 1
        while_done = true
      end
    end
    row_bottom_end = row_index
    row_index = @position_row
    while_done = false
    while row_index > 0 && !while_done
      row_index -= 1
      if board[row_index][@position_col] != 0
        row_index += 1
        while_done = true
      end
    end
    row_top_end = row_index
    (col_left_end..col_right_end).each do |col|
      move = [@position_row, col]
      unless move == [@position_row, @position_col]
        moves.append move
      end
    end
    (row_top_end..row_bottom_end).each do |row|
      move = [row, @position_col]
      unless move == [@position_row, @position_col]
        moves.append move
      end
    end
    moves
  end
end
