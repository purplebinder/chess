module Chess
  module Pieces
    class Bishop < Chess::Pieces::Base

      def to_s
        'B'
      end

      def can_move?(vector)
        vector.dx.abs == vector.dy.abs
      end

    end
  end
end
