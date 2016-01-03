class Board
  attr_reader :pattern, :length, :height
  attr_accessor :grid

  def initialize(args={})
    args = defaults.merge(args)

    @length = args[:length]
    @height = args[:height]
    @pattern = args[:pattern] || random_pattern(self.length, self.height)
    @grid = Array.new(self.length){ Array.new(self.height) }
    load_board(self.pattern)
  end

  def load_board(pattern)
    rows = pattern.split("\n")
    init_grid(rows)
  end

  def init_grid(rows)
    rows.each_with_index do |row, y|
      row.split("").each_with_index do |indicator, x|
        cell_args = get_cell_args(x, y, indicator)
        self.grid[x][y] = Cell.new(cell_args)
      end
    end
  end

  def cell_at(coords)
    self.grid[coords.first][coords.last]
  end

  def get_cell_args(x, y, indicator)
    {x: x, y: y, alive: alive_from(indicator)}
  end

  def alive_from(indicator)
    indicator == '*' ? true : false
  end

  def random_pattern(length, height)
    [*0...height].each_with_object("") do |y, row|
      length.times { row << ['*','-'].sample }
      row << "\n"
    end
  end

  def defaults
    {length: 15,
      height: 15,
      pattern: nil}
  end

  def off_board_above?(coords)
    coords.last < 0
  end

  def off_board_below?(coords)
    coords.last >= height
  end

  def off_board_right?(coords)
    coords.first >= length
  end

  def off_board_left?(coords)
    coords.first < 0
  end

  def on_board?(coords)
    !(off_board_left?(coords) ||
      off_board_right?(coords) ||
      off_board_above?(coords) ||
      off_board_below?(coords))
  end

  def coords_adjacent(coords)
    [[coords.first - 1, coords.last],
     [coords.first + 1, coords.last]]
  end

  def coords_above(coords)
    [[coords.first - 1, coords.last - 1],
     [coords.first, coords.last - 1],
     [coords.first + 1, coords.last - 1]]
  end

  def coords_below(coords)
    [[coords.first - 1, coords.last + 1],
     [coords.first, coords.last + 1],
     [coords.first + 1, coords.last + 1]]
  end

  def raw_neighbor_coords_for(coords)
    coords_above(coords)
    .concat(coords_below(coords))
    .concat(coords_adjacent(coords))
  end

  def neighbor_coords_for(coords)
    raw_neighbor_coords_for(coords).select do |coords|
      on_board?(coords)
    end
  end

  def neighbors_for(cell)
    neighbor_coords_for(cell.coords).map do |coords|
      self.grid[coords.first][coords.last]
    end
  end

  def live_neighbors_for(cell)
    neighbors_for(cell).count { |cell| cell.alive? }
  end

  def to_s
    [*0...height].each_with_object("") do |y, output|
      [*0...length].each do |x|
        output << self.grid[x][y].to_s
      end
      output << "\n"
    end
  end

  def to_file
    [*0...height].each_with_object("") do |y, output|
      [*0...length].each do |x|
        output << self.grid[x][y].to_file
      end
      output << "\n"
    end
  end
end