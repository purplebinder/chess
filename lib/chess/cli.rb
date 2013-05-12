module Chess
  class Cli
    def self.run(args, out = STDOUT)
      board = Chess::Board.new
      out << board.to_s + "\n" + "#{board.turn}'s move> "
      while(line = gets)
        p1, p2 = line.split(/,\s*/)
        if board.move(p1.strip, p2.strip)
          out << board.to_s + "\n" + "#{board.turn}'s move> "
        else
          out << "Invalid move, try again.  #{board.turn}'s move> "
        end
      end
    end
  end
end
