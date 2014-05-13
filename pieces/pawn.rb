#encoding: utf-8

class Pawn < Piece
  
  WHITE = "♙"
  BLACK = "♟"
  
  def moves
    moves = []
    row, col = position
    moves << [row + forward(1), col] unless @board[row + forward(1), col]

    unless @board[row + forward(1), col] || @board[row + forward(2), col]
      moves << [row + forward(2), col] if row == (color == :white ? 6 : 1)
    end
    
    diagonal_moves = diagonal(row, col).select do |pos|
      @board[*pos] && @board[*pos].color != color
    end
    moves + diagonal_moves
  end
  
  private
  
  def forward(y)
    color == :white ? y * -1 : y
  end
  
  def diagonal(row, col)
    diags = []
    diags << [row + forward(1), col + 1] << [row + forward(1), col - 1]
    diags.select { |pos| pos[0].between?(0,7) && pos[1].between?(0,7) }
  end  
end