#encoding utf-8

require 'pry'

require_relative 'board'
require_relative 'pieces/piece'
require_relative 'pieces/stepping_piece'
require_relative 'pieces/sliding_piece'
require_relative 'pieces/pawn'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'invalid_move_error'

class Chess
  
  def initialize(player1, player2)
    @white_player = player1
    @black_player = player2
    @current_player = @white_player
  end
  
  def play
    begin
      move = play_turn
      #board.move(*move)
    rescue InvalidMoveError => e
      puts e.message 
      retry
    end
    
    @current_player == @white_player ? @black_player : @white_player
  end
  
  def get_move
    
  end
  #remember to flip board
  # board saving
end

class HumanPlayer
  
  def play_turn
    get_move = gets.chomp
  end

b = Board.new
b.move([1,0], [3,0])
b.move([0,0], [2,0])
b.move([2,0], [2,4])
b.move([6,4], [4,4])
b.move([1,3], [3,3])
b.display
puts
c = Board.new
c.move([6,5], [5,5])
c.move([1,4], [3,4])
c.move([6,6], [4,6])
c.move([0,3], [4,7])
c.display

pry