class SlidingPiece < Piece
  
  def moves
    moves = []
    self.class::DIRECTIONS.each do |direction|
      #dir = direction.dup
      row, col = position[0] + direction[0], position[1] + direction[1]
      while row.between?(0,7) && col.between?(0,7)
        
        break if @board[row, col] && @board[row, col].color == color
        moves << [row, col]
        row, col = row + direction[0], col + direction[1]
        break if @board[row, col] # must be other color
      end
    end
    moves
  end
end