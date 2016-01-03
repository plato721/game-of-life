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