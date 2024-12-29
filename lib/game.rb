require './lib/board.rb'
require './lib/levels.rb'

class Game
  attr_accessor :current_board

  def initialize(args = {})
    @current_board = init_board(args)
  end

  def play
    until over?
      system("CLEAR")
      puts current_board
      sleep 0.25
      self.current_board = update_board
    end
  end

  def length
    self.current_board.length
  end

  def height
    self.current_board.height
  end

  def update_board
    [*0...height].each_with_object(current_board.copy) do |y, next_board|
      [*0...length].each do |x|
        current_cell = current_board.cell_at([x, y])
        next_board.cell_at([x, y]).alive = alive_next_round?(current_cell)
      end
    end
  end

  def init_board(args)
    return create_board_with(args) if args[:pattern]
    return create_random_board
  end

  def create_random_board
    @current_board = Board.new
  end

  def create_board_with(args)
    length = args[:pattern].split("\n").first.length
    height = args[:pattern].split("\n").length
    Board.new(pattern: args[:pattern], length: length, height: height)
  end

  def over?
    self.current_board.to_s == update_board.to_s
  end

  def alive_next_round?(cell)
    return reanimate?(cell) if !cell.alive?
    return false if self.current_board.live_neighbors_for(cell) < 2
    return false if self.current_board.live_neighbors_for(cell) > 3
    true
  end

  def reanimate?(cell)
    self.current_board.live_neighbors_for(cell) == 3
  end
end