class Piece
  attr_reader :color
  
  attr_accessor :position
  
  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
    board[*position] = self
  end
  
  def display
    color == :white ? self.class::WHITE : self.class::BLACK
  end
  
  def row
    position[0]
  end
  
  def col
    position[1]
  end
  
  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end
  
  private
  
  def move_into_check?(pos)
    example_board = @board.dup
    example_board.move!(position, pos)
    example_board.in_check?(color)
  end
end