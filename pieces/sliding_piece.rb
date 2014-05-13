class SlidingPiece < Piece
  
  def moves
    moves = []
    DIRECTIONS.each do |direction|
      dir = direction.dup
      while (position[0] + dir[0]).between?(0,7) && (position[1] + dir[1]).between?(0,7)
        moves << [position[0] + dir[0], position[1] + dir[1]]
        dir = [dir[0] + direction[0], dir[1] + direction[1]]
      end
    end
    moves
  end
end