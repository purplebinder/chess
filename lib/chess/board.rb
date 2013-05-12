module Chess
  class Board
    HEADER_STRING = "    a b c d e f g h"
    BLANK_ROW = {"a" => nil, "b" => nil, "c" => nil, "d" => nil, "e" => nil, "f" => nil, "g" => nil, "h" => nil}
    BLANK_BOARD = {1 =>  nil, 2 => nil, 3 =>  nil, 4 =>  nil, 5 =>  nil, 6 =>  nil, 7 =>  nil, 8 =>  nil} 
    WHITE_PIECES = {
      "a1" => Chess::Pieces::Base, # should be a Rook
      "b1" => Chess::Pieces::Base, # should be a Knight
      "c1" => Chess::Pieces::Base, # should be a Bishop
      "d1" => Chess::Pieces::Base, # should be a King (or Queen?)
      "e1" => Chess::Pieces::Base, # should be a Queen (or King?)
      "f1" => Chess::Pieces::Base, # should be a Bishop
      "g1" => Chess::Pieces::Base, # should be a Knight
      "h1" => Chess::Pieces::Base, # should be a Rook
      "a2" => Chess::Pieces::Pawn,
      "b2" => Chess::Pieces::Pawn,
      "c2" => Chess::Pieces::Pawn,
      "d2" => Chess::Pieces::Pawn,
      "e2" => Chess::Pieces::Pawn,
      "f2" => Chess::Pieces::Pawn,
      "g2" => Chess::Pieces::Pawn,
      "h2" => Chess::Pieces::Pawn
    }
    BLACK_PIECES = {
      "a8" => Chess::Pieces::Base, # should be a Rook
      "b8" => Chess::Pieces::Base, # should be a Knight
      "c8" => Chess::Pieces::Base, # should be a Bishop
      "d8" => Chess::Pieces::Base, # should be a King (or Queen?)
      "e8" => Chess::Pieces::Base, # should be a Queen (or King?)
      "f8" => Chess::Pieces::Base, # should be a Bishop
      "g8" => Chess::Pieces::Base, # should be a Knight
      "h8" => Chess::Pieces::Base, # should be a Rook
      "a7" => Chess::Pieces::Pawn,
      "b7" => Chess::Pieces::Pawn,
      "c7" => Chess::Pieces::Pawn,
      "d7" => Chess::Pieces::Pawn,
      "e7" => Chess::Pieces::Pawn,
      "f7" => Chess::Pieces::Pawn,
      "g7" => Chess::Pieces::Pawn,
      "h7" => Chess::Pieces::Pawn
    }

    def initialize
      @board = BLANK_BOARD.dup
      @board.each { |key, val| @board[key] = BLANK_ROW.dup }
      WHITE_PIECES.each do |position, piece_class|
        set_piece(position, piece_class.new("White"))
      end
      BLACK_PIECES.each do |position, piece_class|
        set_piece(position, piece_class.new("Black"))
      end
    end

    ### METHODS FOR PRINTING A BOARD
    def to_s
      @board.inject(HEADER_STRING.dup) do |output_string, key_val|
        row_index = key_val[0]
        row = key_val[1]
        output_string + "\n" + row_to_s(row_index, row)
      end
    end

    def row_to_s(row_index, row)
      row.inject(" #{row_index} ") do |output_string_for_row, key_val|
        col_index = key_val[0]
        piece = key_val[1]
        output_string_for_row + ' ' + position_to_s(piece)
      end
    end

    def position_to_s(piece)
      if piece.nil?
        '.'
      else
        piece.to_s
      end
    end

    ###  END OF SECTION ON PRINTING

    def move(from, to)
      piece = get_piece(from)
      if piece.can_move?(to, self)
        set_piece(to, piece)
        return true
      else
        return false
      end
    end

    def set_piece(position, piece)
      @board[piece.row][piece.col] = nil if piece.row and piece.col
      piece.row = position[1].to_i
      piece.col = position[0].downcase
      @board[position[1].to_i][position[0].downcase] = piece
    end

    def get_piece(position)
      @board[position[1].to_i][position[0].downcase]
    end
  end
end