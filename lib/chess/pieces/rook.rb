module Chess
  module Pieces
    class Rook < Chess::Pieces::Base

      def to_s
        'R'
      end

      def can_move?(vector)
        vector.dx == 0 or vector.dy == 0
      end

    end
  end
end
