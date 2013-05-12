module Chess
  module Pieces
    class Base
      attr_accessor :row, :col

      def initialize(color)
        @color = color
      end

      def to_s
        "x"
      end

      def can_move?(position, board)
        true
      end
    end
  end
end
