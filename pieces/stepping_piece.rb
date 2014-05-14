class SteppingPiece < Piece
  
  def moves
    moves = []
    
    self.class::DIRECTIONS.each do |direction|
      row, col = self.row + direction[0], self.col + direction[1]
      if row.between?(0,7) && col.between?(0,7)
        moves << [row, col]
      end
    end
    moves.reject do |pos|
      @board.occupied?(*pos) == color
    end
  end
  
end