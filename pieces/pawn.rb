#encoding: utf-8

class Pawn < Piece
  
  WHITE = "♙"
  BLACK = "♟"
  
  def moves
    moves = []
    
    unless @board[forward(1), col]
      moves << [forward(1), col] 

      if !@board[forward(2), col] && starting_row?
        moves << [forward(2), col]
      end
    end
    
    diagonal_moves = diagonal(row, col).select do |pos|
      @board.occupied?(*pos) && @board.occupied?(*pos) != color
    end
    
    moves + diagonal_moves
  end
  
  protected
  def starting_row?
    row == (color == :white ? 6 : 1)
  end
  
  private
  
  def forward(y)
    row + (color == :white ? y * -1 : y)
  end
  
  def diagonal(row, col)
    diags = [[forward(1), col + 1], [forward(1), col - 1]]
    diags.select { |pos| pos[0].between?(0,7) && pos[1].between?(0,7) }
  end  
end