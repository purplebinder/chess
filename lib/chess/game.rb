module Chess
  class Game
    attr_reader :board, :turn
    def initialize
      @turn = "White"
      @board = Chess::Board.new
    end

    def to_s
      board.to_s
    end

    def move(from, to)
      if board.move(from, to)
        @turn = (['White', 'Black'] - [@turn])[0]
        return true
      else
        return false
      end
    end

  end
end
