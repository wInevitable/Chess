class SteppingPiece < Piece
  
  def moves
    moves = []
    
    self.class::DIRECTIONS.each do |direction|
      row, col = position[0] + direction[0], position[1] + direction[1]
      if row.between?(0,7) && col.between?(0,7)
        moves << [row, col]
      end
    end
    moves.reject do |pos|
      @board[*pos] && @board[*pos].color == color
    end
  end
  
end