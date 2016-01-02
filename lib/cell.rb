class Cell
  attr_reader :x, :y
  attr_accessor :alive

  def initialize(args = defaults)
    args = defaults.merge(args)
    @alive = args[:alive]
    @x = args[:x]
    @y = args[:y]
  end

  def defaults
    {alive: false,
      x: 0,
      y: 0}
  end

  def alive?
    self.alive
  end

  def coords
    [x, y]
  end

  def flip_alive
    self.alive = !self.alive
  end
end