require 'colorize'

class Board
  
  def initialize
    @board = Array.new(8) { Array.new(8) }
    set_pawns(1, :black)
    set_pieces(0, :black)
    set_pawns(6, :white)
    set_pieces(7, :white)
  end
  
  def [](row, col)
    @board[row][col]
  end
  
  def display
    @board.each_index do |row|
      @board[row].each_with_index do |square, col|
        pos = (square.nil? ? ' ' : square.display).center(3)
        pos = pos.colorize(:background => :light_black) if (row + col).odd?
        print pos
      end
      puts
    end
    
    nil
  end
  
  protected
  
  def set_pawns(row, color)
    @board[row] = Array.new(8) { |index| Pawn.new(self, [row, index], color)}
  end
  
  def set_pieces(row, color)
    @board[row] = [Rook.new(self, [row, 0], color),
                   Knight.new(self, [row, 1], color),
                   Bishop.new(self, [row, 2], color),
                   Queen.new(self, [row, 3], color),
                   King.new(self, [row, 4], color),
                   Bishop.new(self, [row, 5], color),
                   Knight.new(self, [row, 6], color),
                   Rook.new(self, [row, 7], color)]
  end
        
end