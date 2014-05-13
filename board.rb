require 'colorize'

class Board
  
  def initialize
    @board = Array.new(8) { Array.new(8) }
    set_pawns(1, :black)
    set_pieces(0, :black)
    set_pawns(6, :white)
    set_pieces(7, :white)
  end
  
  def [](row, col)
    @board[row][col]
  end
  
  def []=(row, col, value)
    @board[row][col] = value
  end
  
  def display
    puts '   ' + ('a'..'h').to_a.join('  ')
    @board.each_index do |row|
      print (8-row).to_s + ' '
      @board[row].each_with_index do |square, col|
        pos = (square.nil? ? ' ' : square.display).center(3)
        pos = pos.colorize(:background => :light_black) if (row + col).odd?
        print pos
      end
      puts
    end
    
    nil
  end
  
  def in_check?(color)
    king = @board.flatten.select do |square|
      square.is_a?(King) && square.color == color
    end .first
    
    @board.flatten.any? do |piece|
      next if piece.nil? || piece.color == color
      piece.moves.include?(king.position)
    end
  end
  
  def move!(start, end_pos)
    piece = self[*start]
    if piece.nil? 
      raise InvalidMoveError.new("Please choose a position with a piece.")
    elsif piece.moves.none? { |move| move == end_pos }
      raise InvalidMoveError.new("Invalid Move. Try Again.")
    end
    self[start[0], start[1]], self[end_pos[0], end_pos[1]] = nil, piece
    piece.position = end_pos
  end
  
  def move(start, end_pos, color)
    piece = self[*start]
    if piece.nil? 
      raise InvalidMoveError.new("Please choose a position with a piece.")
    elsif piece.valid_moves.none? { |move| move == end_pos }
      raise InvalidMoveError.new("Invalid Move. Try Again.")
    elsif piece.color != color
      raise InvalidMoveError.new("That ain't yo piece yo")
    else
      p piece.color, color
    end
    self[start[0], start[1]], self[end_pos[0], end_pos[1]] = nil, piece
    piece.position = end_pos
  end
  
  def dup
    new_board = Array.new(8) { Array.new(8) }
    pieces = @board.flatten.select { |square| square.is_a?(Piece) }
    board_object = Board.new
    
    pieces.map! { |piece| piece.dup(board_object) }
    pieces.each do |piece|
      new_board[piece.row][piece.col] = piece
    end
    
    board_object.board = new_board
    board_object
  end
  
  def checkmate?(color)
    pieces(color).all? { |piece| piece.valid_moves.empty? }
  end
  
  def pieces(color)
    @board.flatten.compact.select { |square| square.color == color }
  end
  
  protected
  
  def set_pawns(row, color)
    @board[row] = Array.new(8) { |index| Pawn.new(self, [row, index], color)}
  end
  
  def set_pieces(row, color)
    @board[row] = [Rook.new(self, [row, 0], color),
                   Knight.new(self, [row, 1], color),
                   Bishop.new(self, [row, 2], color),
                   Queen.new(self, [row, 3], color),
                   King.new(self, [row, 4], color),
                   Bishop.new(self, [row, 5], color),
                   Knight.new(self, [row, 6], color),
                   Rook.new(self, [row, 7], color)]
  end
  
  attr_accessor :board
        
end