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
  
  attr_reader :board, :current_player, :players
  
  def initialize
    @board = Board.new  
    @players = { :white => HumanPlayer.new(:white),
      :black => HumanPlayer.new(:black) }
    @current_player = :white
  end
  
  def play
    until over?
      if board.in_check?(current_player)
        puts "#{current_player.to_s.capitalize} is in check."
      end
      begin
        start, end_pos = players[current_player].play_turn(self)
        board.move(start, end_pos, current_player)
      rescue IOError, InvalidMoveError => e
        puts e.message 
        retry
      end
      
      switch_turn
    end
    
    board.display
    puts "#{:current_player} is checkmated."
    
    nil
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
    @current_player = (current_player == :white) ? :black : :white
  end
  
  def over?
    @board.checkmate?(:white) || @board.checkmate?(:black)
  end

  #remember to flip board
end

class HumanPlayer
  
  attr_reader :color
  
  def initialize(color)
    @color = color
  end
  
  def play_turn(game)
    game.board.display
    puts "Current player: #{color}"
    
    from_pos = get_pos('From pos:')
    to_pos = get_pos('To pos:')
    
    #get_move = gets.chomp.split(",")
    if from_pos == "save"
      game.save(to_pos)
      return play_turn(game)
      
    elsif from_pos == "flipboard"
      system("open http://i.imgur.com/wYkU5Yn.gif")
      abort("!!!")

    else
      parse_coords(from_pos, to_pos)
    end

  end
  
  private
  
  def get_pos(prompt)
    puts prompt
    coords = gets.chomp
  end
  
  def parse_coords(from, to)
    coords = [from, to]
    coords.map do |cor|
      unless /[a-h][1-8]/ === cor
        raise IOError.new("Enter Coordinates between A0-H8 OR
        save and 'filename'")
      end
      [8 - cor[1].to_i, ('a'..'h').to_a.index(cor[0])]
    end
  end
  
end

g = Chess.new
b = Board.new
b.move([6,5],[5,5], :white)
b.move([1,4],[3,4], :black)
b.move([6,6],[4,6], :white)
b.move([0,3],[4,7], :black)
b.display
pry