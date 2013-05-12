module Chess
  class Position
    class OutOfBoundsError < StandardError; end
    class BadArgumentError < StandardError; end
    VALID_COLUMNS = %w[a b c d e f g h]
    VALID_ROWS = [1, 2, 3, 4, 5, 6, 7, 8]

    BAD_COLUMN_ERROR_MESSAGE = 'Column out of bounds. Columns must be in the range a through h.'
    BAD_ROW_ERROR_MESSAGE = 'Row out of bounds. Rows must be in the range 1 through 8.'
    BAD_ARGUMENT_ERROR_MESSAGE = 'You must supply a two character position string, like this: Chess::Position.new("a4")'

    attr_reader :row, :column, :x, :y

    def initialize(position_string)
      self.class.raise_error_for(position_string) unless self.class.valid?(position_string)
      @row, @column = self.class.extract_args(position_string)
      @x = (VALID_COLUMNS.index(@column) + 1)
      @y = (-1 * @row)
    end

    def to_s
      @column + @row.to_s
    end

    class << self
      def valid?(position_string)
        begin
          raise_error_for(position_string)
          return true
        rescue
          return false
        end
      end

      def raise_error_for(position_string)
        raise BadArgumentError.new(BAD_ARGUMENT_ERROR_MESSAGE) unless position_string.length == 2
        row, column = self.extract_args(position_string)
        raise OutOfBoundsError.new(BAD_COLUMN_ERROR_MESSAGE + " You supplied #{position_string[1]}.") unless VALID_COLUMNS.include?(column)
        raise OutOfBoundsError.new(BAD_ROW_ERROR_MESSAGE + " You supplied #{row}.") unless VALID_ROWS.include?(row)
      end

      def extract_args(position_string)
        return [position_string[1].to_i, position_string[0].downcase]
      end
    end

  end
end
