### 
#  The board maintains a representation of a physical board,
#  storing it as a hash of hashes.
#
#  The board can print a string representation of itself, which will look
#  sort of like this:
#
#                a b c d e f g h
#             1  R N B K Q B N R
#             2  p p p p p p p p
#             3  . . . . . . . .
#             4  . . . . . . . .
#             5  . . . . . . . .
#             6  . . . . . . . .
#             7  p p p p p p p p
#             8  R N B K Q B N R
#
#  It stores the current "turn", i.e. White or Black, as an instance variable.
#  The board receive move commands, which are supposed to come as pairs of
#  position strings.
#      
#      # Opening move for white: advance a pawn two spaces
#      board.move("b2", "b4")
#
#  It needs to assess whether these are valid moves, and return true if they are,
#  false otherwise.
#
module Chess
  class Board
    HEADER_STRING = "    a b c d e f g h".color(:green)
    BLANK_ROW = {"a" => nil, "b" => nil, "c" => nil, "d" => nil, "e" => nil, "f" => nil, "g" => nil, "h" => nil}
    BLANK_BOARD = {1 =>  nil, 2 => nil, 3 =>  nil, 4 =>  nil, 5 =>  nil, 6 =>  nil, 7 =>  nil, 8 =>  nil} 
    WHITE_PIECES = {
      "a1" => Chess::Pieces::Rook,
      "b1" => Chess::Pieces::Knight,
      "c1" => Chess::Pieces::Bishop,
      "d1" => Chess::Pieces::King,
      "e1" => Chess::Pieces::Queen,
      "f1" => Chess::Pieces::Bishop,
      "g1" => Chess::Pieces::Knight,
      "h1" => Chess::Pieces::Rook,
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
      "a8" => Chess::Pieces::Rook,
      "b8" => Chess::Pieces::Knight,
      "c8" => Chess::Pieces::Bishop,
      "d8" => Chess::Pieces::King,
      "e8" => Chess::Pieces::Queen,
      "f8" => Chess::Pieces::Bishop,
      "g8" => Chess::Pieces::Knight,
      "h8" => Chess::Pieces::Rook,
      "a7" => Chess::Pieces::Pawn,
      "b7" => Chess::Pieces::Pawn,
      "c7" => Chess::Pieces::Pawn,
      "d7" => Chess::Pieces::Pawn,
      "e7" => Chess::Pieces::Pawn,
      "f7" => Chess::Pieces::Pawn,
      "g7" => Chess::Pieces::Pawn,
      "h7" => Chess::Pieces::Pawn
    }

    PLAYERS = ['White', 'Black']

    attr_reader :turn

    def initialize
      @board = BLANK_BOARD.dup
      @board.each { |key, val| @board[key] = BLANK_ROW.dup }
      WHITE_PIECES.each do |position, piece_class|
        set_piece(position, piece_class.new("White"))
      end
      BLACK_PIECES.each do |position, piece_class|
        set_piece(position, piece_class.new("Black"))
      end
      @turn = PLAYERS[0]  # 'White'
      self
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
      row.inject(" #{row_index} ".color(:green)) do |output_string_for_row, key_val|
        col_index = %w[a b c d e f g h].index(key_val[0]) + 1
        piece = key_val[1]
        background_color = (((row_index + col_index) % 2 == 0) ? :white : :blue)
        output_string_for_row + ' ' + position_to_s(piece, background_color)
      end
    end

    def position_to_s(piece, background_color)
      if piece.nil?
        '.'.color(background_color)
      else
        piece.to_s.color(piece.color == 'White' ? :white : :blue)
      end
    end

    ###  END OF SECTION ON PRINTING

    ### Move
    #   This method is a beast, but it just does a lot of checks to 
    #   see if the move is valid.
    #   If any of them fail, it returns false.
    #   Specifically, move is invalid if
    #     * You are "moving" a piece in place, i.e. not really moving it.
    #     * You are moving nothing, i.e. the start position is an empty square with no piece on it.
    #     * You are moving the other player's piece.  
    #       The board knows whose turn it is, and will only let you move pieces of that color.
    #     * The piece in question cannot jump (i.e. anything but a knight) and there is no direct
    #       path between the start and end positions.
    #     * You are trying to land on your own piece.
    #
    #   If all of these checks pass, the method returns true.
    #
    def move(from, to)
      if from == to
        return false
        # TODO set error message
      end
      piece = get_piece(from)
      if piece.nil?
        return false
        # TODO set error message
      end
      if piece.color != turn
        return false
        # TODO set error message
      end
      vector = Chess::Vector.new(from, to)
      unless piece.can_jump? or path_clear?(vector.to_a)
        return false
        # TODO set error message
      end
      target_piece = get_piece(to)

      if target_piece and target_piece.color == piece.color  # don't land on your own pieces
        return false
        # TODO set error message
      end

      if piece.can_move?(vector, (!!target_piece))
        remove_piece(from)
        set_piece(to, piece)
        @turn = (PLAYERS - [@turn])[0]  # toggle turn
        return true
      else
        return false
      end
    end

    ### Helper for the move method

    def path_clear?(vector)
      steps = vector.to_a
      steps.slice!(-1) # remove final step, which is the destination
      steps.each do |position|
        if get_piece(position) != nil
          return false
        end
      end
      return true
    end


    ### Utility methods for getting and setting pieces on the board
    
    def set_piece(position_string, piece)
      position = Chess::Position.new(position_string)
      @board[position.row][position.column] = piece
    end

    def get_piece(position_string)
      position = Chess::Position.new(position_string)
      @board[position.row][position.column]
    end

    def remove_piece(position_string)
      position = Chess::Position.new(position_string)
      @board[position.row][position.column] = nil
    end
  end

end
