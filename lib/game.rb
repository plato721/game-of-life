class Game
  attr_reader :current_board

  def initialize(args = {})
    @current_board = init_board(args)
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
    self.current_board.to_s.count('*') == 0
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