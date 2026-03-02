#require all pieces
Dir["./Pieces/*.rb"].each {|file| require file }

class Board
  attr_accessor :board, :white_turn, :halfmoves, :fullmoves,
  :white_castel_queen_side, :white_castel_king_side, :black_castel_queen_side, :black_castel_king_side

  def initialize(fen_string="rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
    self.init_empty_board
    self.setPosition(fen_string)
    self.print_board
    puts self.check_move("Ng6-h4") # for testing
  end

  def print_board
    board.each_with_index do |row, index|
      print "#{8-index}|"
      row.each do |col|
        print "#{col}|"
      end
      puts
    end
    puts "  A|B|C|D|E|F|G|H"
    puts "Turn: #{white_turn ? "White" : "Black"}"
    puts "Castle:
     #{white_castel_king_side ? "White Kingside" : ""}, #{white_castel_queen_side ? "White Queenside" : ""},
     #{black_castel_king_side ? "Black Kingside" : ""}, #{black_castel_queen_side ? "Black Queenside" : ""}"
    puts "Halfmoves: #{halfmoves}"
    puts "Fullmoves: #{fullmoves}"
  end

  def make_move(move)
    # pc7-c6
    if move.length > 6
      #promotion
    elsif move.split("-").length > 1
      
    elsif move.split("x").length > 1
      #capture
    else
      #invalid move
    end
  end

  def self.board_index_valid?(indexs)
    if indexs[0] > 7 || indexs [0] < 0 || indexs[1] > 7 || indexs[1] < 0
      false
    else
      true
    end
  end

  def check_move(move)
    move_split = move.split("-")
    start = move_split[0]
    start_split = start.split("")
    row_index = 8 - start_split[2].to_i
    col_index = self.char_to_col_index(start_split[1])
    translated_move_start = [row_index, col_index]
    puts "row:#{translated_move_start[0]}"
    puts "col:#{translated_move_start[1]}"
    unless Board.board_index_valid?(translated_move_start)
      puts "index invalid"
      return false
    end
    if start_split[0] != @board[row_index][col_index].to_s
      puts "no same piece invalid"
      return false
    end
    end_of_move = move_split[1]
    end_split = end_of_move.split("")
    col_index = self.char_to_col_index(end_split[0])
    row_index = 8 - end_split[1].to_i
    translated_move_end = [row_index, col_index]
    moves = @board[translated_move_start[0]][translated_move_start[1]].get_all_moves(@board)
    puts moves
    if moves.include? translated_move_end
      true
    else 
      false
    end
  end

  private

    def char_to_col_index(char)
      char.downcase.ord - 'a'.ord
    end

    def init_empty_board
      @board = [
        [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0]
      ]
      @white_turn = true
      @white_castel_queen_side = false
      @white_castel_king_side = false
      @black_castel_queen_side = false
      @black_castel_king_side = false
      @halfmoves = 0
      @fullmoves = 0
    end
  
    def setPosition(fen_string)
      fen_space_split = fen_string.split(" ")
      fen_positions = fen_space_split[0]
      fen_pos_split = fen_positions.split("/")
      self.set_fen_position(fen_pos_split)
      @white_turn = fen_space_split[1] == "w" ? true : false
      # Show wich side can Castel
      fen_space_split[2].split("").each do |char|
        if char == "-" || char == " "
          next
        elsif char == "K"
          @white_castel_king_side = true
        elsif char == "Q"
          @white_castel_queen_side = true
        elsif char == "k"
          @black_castel_king_side = true
        elsif char == "q"
          @black_castel_queen_side = true
        end
      end
      @halfmoves = fen_space_split[4].to_i
      @fullmoves = fen_space_split[5].to_i
    end
  
    def set_fen_position(fen_pos_split)
      fen_pos_split.each_with_index do |row, row_index|
        col_index = 0
        row.split("").each do |char|
          if Integer(char, exception: false)
            col_index += char.to_i
          else
            self.set_piece(row_index, col_index, char)
            col_index += 1
          end
        end
      end
    end
  
    def set_piece(row_index, col_index, piece_str)
      case piece_str
      when "P"
        piece = Pawn.new(:white, [row_index, col_index])
      when "p"
        piece = Pawn.new(:black, [row_index, col_index])
      
      when "R"
        piece = Rook.new(:white, [row_index, col_index])
      when "r"
        piece = Rook.new(:black, [row_index, col_index])
      
      when "N"
        piece = Knight.new(:white, [row_index, col_index])
      when "n"
        piece = Knight.new(:black, [row_index, col_index])
      
      when "B"
        piece = Bishop.new(:white, [row_index, col_index])
      when "b"
        piece = Bishop.new(:black, [row_index, col_index])
      
      when "Q"
        piece = Queen.new(:white, [row_index, col_index])
      when "q"
        piece = Queen.new(:black, [row_index, col_index])
      
      when "K"
        piece = King.new(:white, [row_index, col_index])
      when "k"
        piece = King.new(:black, [row_index, col_index])
      else
        piece = nil
      end
      @board[row_index][col_index] = piece
    end
end

Board.new("r2qk2r/pbp2ppp/1p3nN1/b2pp3/1P1P1B2/2PBP3/P4PPP/RN1Q1RK1 b kq - 2 8")
