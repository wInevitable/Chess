class SteppingPiece < Piece
  
  def moves
    moves = []
    
    DIRECTION.each do |dir|
      if (position[0] + dir[0]).between?(0,7) && (position[1] + dir[1]).between?(0,7)
        moves << [position[0] + dir[0], position[1] + dir[1]]
      end
    end
    moves
  end
  
end