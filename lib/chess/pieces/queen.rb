module Chess
  module Pieces
    class Queen < Chess::Pieces::Base

      def to_s
        'Q'
      end

      def can_move?(vector)
        vector.dx.abs == vector.dy.abs or vector.dx == 0 or vector.dy == 0
      end

    end
  end
end
