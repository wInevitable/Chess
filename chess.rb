#encoding: utf-8

require 'pry'
require 'yaml'

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
require_relative 'board'

class Chess
  
  def initialize(player1, player2)
    @white_player = player1
    @white_player.color = :white
    @black_player = player2
    @black_player.color = :black
    @current_player = @white_player
    @board = Board.new
  end
  
  def play
    until over?
      @board.display
      if @board.in_check?(@current_player.color)
        puts "#{@current_player.color.to_s.capitalize} is in check."
      end
      begin
        start, end_pos = @current_player.play_turn(self)
        @board.move(start, end_pos, @current_player.color)
      rescue IOError, InvalidMoveError => e
        puts e.message 
        retry
      end
      
      switch_turn
    end
    @board.display
    puts "Game Over!"
  end
  
  def save(filename)
    File.open(filename, 'w') do |f|
      f.puts to_yaml
    end
  end
  
  def self.load(filename)
    YAML::load_file(filename)
  end
  
  private
  
  def switch_turn
    if @current_player == @white_player
      @current_player = @black_player
    else
      @current_player = @white_player
    end
  end
  
  def over?
    @board.checkmate?(:white) || @board.checkmate?(:black)
  end

  #remember to flip board
end

class HumanPlayer
  
  attr_accessor :color
  
  def play_turn(game)
    get_move = gets.chomp.split(",")
    if get_move[0] == "save"
      game.save(get_move[1])
      return play_turn(game)
      
    elsif get_move[0] == "flipboard"
      system("open http://i.imgur.com/wYkU5Yn.gif")
      abort("GOD DAMNIT!")

    else
      parse_coords(get_move)
    end

  end
  
  private
  
  def parse_coords(coords)
    coords.map do |cor|
      unless /[a-h][1-8]/ === cor
        raise IOError.new("Enter Coordinates between A0-H8 or save,'filename'")
      end
      [8 - cor[1].to_i, ('a'..'h').to_a.index(cor[0])]
    end
  end
  
end

g = Chess.new(HumanPlayer.new, HumanPlayer.new)
b = Board.new
b.move([6,5],[5,5], :white)
b.move([1,4],[3,4], :black)
b.move([6,6],[4,6], :white)
b.move([0,3],[4,7], :black)
b.display
pry