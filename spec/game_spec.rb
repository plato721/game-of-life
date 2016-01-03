require './spec/spec_helper.rb'
require './lib/game.rb'

describe Game do
  it 'can be instantiated' do
    expect true
  end

  it 'can create a board with a pattern' do
    pattern = <<-EOF
-*--
**--
-*-*
*-**
EOF
    game = Game.new(pattern: pattern)
  end

  it 'knows when the game is over' do
    game = Game.new(pattern: "--\n--\n", length: 2, height: 2)

    expect(game.over?).to be_truthy
  end

  it 'knows when the game is over with greater than 0 alive' do
    game = Game.new(pattern: "**\n**\n", length: 2, height: 2)

    expect(game.over?).to be_truthy
  end

  context "updating cells" do
    before do
          pattern = <<-EOF
-*--
**--
-*-*
*-**
EOF
      @game = Game.new(pattern: pattern, length: 4, height: 4)
    end

    it "returns true for dead cell with 3 neighbors" do
      cell = @game.current_board.cell_at([0,0])
      expect(cell.alive?).to be_falsey
      expect(@game.alive_next_round?(cell)).to be_truthy
    end

    it "returns false for alive cell with 1 neighbor" do
      cell = @game.current_board.cell_at([0,3])
      expect(cell.alive?).to be_truthy
      expect(@game.alive_next_round?(cell)).to be_falsey
    end

    it "returns true for alive cell with 3 neighbors" do
      cell = @game.current_board.cell_at([1,1])
      expect(cell.alive?).to be_truthy
      expect(@game.alive_next_round?(cell)).to be_truthy
    end

    it "returns false for alive cell with more than 3 neighbors" do
      cell = @game.current_board.cell_at([1,2])
      expect(cell.alive?).to be_truthy
      expect(@game.alive_next_round?(cell)).to be_falsey
    end

  end
end
