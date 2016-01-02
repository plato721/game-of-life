require './spec/spec_helper.rb'
require './lib/cell.rb'

describe Cell do
  it 'can be instantiated with no arguments' do
    expect Cell.new
  end

  it 'knows if it is alive' do
    cell = Cell.new(alive: true)

    expect(cell.alive?).to be_truthy
  end

  it 'has coords' do
    cell = Cell.new(alive: true, x: 3, y: 7)

    expect(cell.coords).to eq([3, 7])
  end

  it 'can be flipped from dead to alive' do
    cell = Cell.new
    expect(cell.alive?).to be_falsey

    cell.flip_alive
    expect(cell.alive?).to be_truthy
  end
end