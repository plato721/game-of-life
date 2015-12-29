require './spec/spec_helper.rb'
require './lib/cell.rb'

describe Cell do
  it 'can be instantiated' do
    expect Cell.new
  end

  it 'can be instantiated with an alive status' do
    cell = Cell.new(alive: true)

    expect(cell.alive?).to be_truthy
  end
end