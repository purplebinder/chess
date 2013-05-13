module Chess
  module Pieces
    class King < Chess::Pieces::Base

      def to_s
        'K'
      end

      def can_move?(vector, kill = false)
        vector.dx.abs <= 1 and vector.dy.abs <= 1
      end

    end
  end
end
