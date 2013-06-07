module Chess
  module Pieces
    class Pawn < Chess::Pieces::Base

      def to_s
        'p'
      end

      def can_move?(vector, kill = false)
        if color == 'White'
          return false unless vector.dy == -1 or (vector.dy == -2 and vector.start.row == 2)
        else  # color == 'Black'
          return false unless vector.dy == 1 or (vector.dy == 2 and vector.start.row == 7)
        end

        if kill
          return false unless vector.dx.abs == vector.dy.abs and vector.dy.abs == 1
        else
          return false unless vector.dx == 0
        end
        true
      end
    end
  end
end
