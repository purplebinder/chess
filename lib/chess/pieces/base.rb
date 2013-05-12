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
        raise "#{self.class} has not implemented the can_move? method.  Implement it in #{__FILE__}"
      end
    end
  end
end
