class SlidingPiece < Piece
  
  def moves
    moves = []
    
    self.class::DIRECTIONS.each do |direction|
      row, col = self.row + direction[0], self.col + direction[1]
      
      while row.between?(0,7) && col.between?(0,7)
        break if @board.occupied?(row, col) == color
        moves << [row, col]

        break if @board[row, col] # must be other color
        row, col = row + direction[0], col + direction[1]
      end
    end
    moves
  end
end