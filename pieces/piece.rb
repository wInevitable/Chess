class Piece
  
  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
    @picture = @color == :white ? WHITE : BLACK
  end
  
  def display
    
  end

end