class Piece
  
  attr_reader :color, :position
  
  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
  end
  
  def display
    :white ? self.class::WHITE : self.class::BLACK
  end

end