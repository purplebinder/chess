module Chess
  module Pieces
    class Knight < Chess::Pieces::Base

      def to_s
        'N'
      end

      def can_jump?; true; end

      def can_move?(vector)
        (vector.dx.abs == 1 and vector.dy.abs == 2) or (vector.dx.abs == 2 and vector.dy.abs == 1)
      end

    end
  end
end
