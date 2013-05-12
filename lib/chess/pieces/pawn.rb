module Chess
  module Pieces
    class Pawn < Chess::Pieces::Base

      def to_s
        'p'
      end

      def can_move?(position, board)
        true
      end
    end
  end
end
