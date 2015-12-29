class Cell
  attr_reader :alive
  def initialize(args = defaults)
    args = defaults.merge(args)
    @alive = args[:alive]
  end

  def defaults
    {alive: false,
      x: 0,
      y: 0}
  end

  def alive?
    self.alive
  end
end