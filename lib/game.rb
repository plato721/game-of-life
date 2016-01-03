class Game
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
end