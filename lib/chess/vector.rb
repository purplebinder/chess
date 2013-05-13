module Chess
  class Vector
    class BadArgumentError < StandardError; end

    attr_reader :dx, :dy, :start, :end

    def initialize(start_position, end_position)
      raise BadArgumentError.new("start position must be different from end position") if start_position == end_position
      @start = Chess::Position.new(start_position)
      @end = Chess::Position.new(end_position)
      @dx = (@end.x - @start.x)
      @dy = (@end.y - @start.y)
      @xhat = (@dx <=> 0)
      @yhat = (@dy <=> 0)
    end

    def adjacent?
      (-1..1).include?(@dx) and (-1..1).include?(@dy)
    end

    def adjacent_position 
      x = @start.x + @xhat
      y = @start.y + @yhat
      Chess::Position::VALID_COLUMNS[x - 1] + Chess::Position::VALID_ROWS[(-1 * y)- 1].to_s  # this is a string, like "e2", for example
    end

    def to_a  # Recursion! Oh boy.
      @vector_array ||= if adjacent?
                          [@end.to_s]
                        else
                          [adjacent_position.to_s] + self.class.new(adjacent_position, @end.to_s).to_a
                        end
    end

  end
end
