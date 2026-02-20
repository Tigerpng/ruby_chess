class Piece
  attr_reader :color, :position

  def initialize(color, position)
    @color = color
    @position_row = position[0]
    @position_col = position[1]
  end

  def fen_symbol
    raise NotImplementedError, "Subclasses must implement fen_symbol"
  end

  def to_s
    color == :white ? fen_symbol.upcase : fen_symbol.downcase
  end

  def board_index_valid?(indexs)
    Board.board_index_valid(indexs)
  end

  def get_all_moves(board, captures)
    raise NotImplementedError, "Subclasses must implement get_all_moves"
  end

end
