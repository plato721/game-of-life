require './spec/spec_helper.rb'
require './lib/board.rb'

describe Board do
  it 'can be instantiated' do
    board = Board.new
  end

  context('reading, writing, enumerating') do
    before do
      @pattern = <<-EOF
---------------
----*----------
---------------
---------------
---------------
---------------
------------*--
------------*--
---------------
---------------
---------------
---------------
---------------
------*--------
---------------
EOF

      @board = Board.new(pattern:@pattern)
    end
    it 'reads in a pattern' do

      expect(@board.cell_at([4, 1]).alive?).to be_truthy
      expect(@board.cell_at([12, 6]).alive?).to be_truthy
      expect(@board.cell_at([12, 7]).alive?).to be_truthy
      expect(@board.cell_at([6, 13]).alive?).to be_truthy
    end

    it 'reads in a another pattern' do
      pattern = <<-EOF
-*--
**--
-*-*
*-**
EOF
      board = Board.new(pattern: pattern)

      expect(board.cell_at([0,0]).alive?).to be_falsey
      expect(board.cell_at([1,0]).alive?).to be_truthy
    end

    it 'has a file representation' do
      expect(@board.to_file).to eq(@pattern)
    end

    it 'has a string reprentation' do
      pattern = <<-EOF
-*--
**--
-*-*
*-**
EOF
      show = <<-EOF
 *  
**  
 * *
* **
EOF
      board = Board.new(pattern: pattern, length: 4, height: 4)
      expect(board.to_s).to eq(show)

    end
  end

  context "neighbors" do
    before do
          pattern = <<-EOF
-*--
**--
-*-*
*-**
EOF
    @board = Board.new(pattern: pattern, height: 4, length: 4)

    end

    it "knows neighbors for a cell" do

      cell = @board.cell_at([2,2])
      neighbors = @board.neighbors_for(cell)
      neighbor_coords = neighbors.map {|cell| cell.coords }

      expected = [[1,1], [2,1], [3,1], [1,2], [3,2], [1,3], [2,3], [3,3]]
      expect(neighbor_coords.sort).to eq(expected.sort)
    end

    it "knows live neighbors for a cell" do
      cell = @board.cell_at([2,2])

      expect(@board.live_neighbors_for(cell)).to eq(5)
    end

    it "knows neighbors for top left" do
      cell = @board.cell_at([0,0])
      neighbors = @board.neighbors_for(cell)
      neighbor_coords = neighbors.map {|cell| cell.coords }

      expected = [[1,0],[0,1],[1,1]]
      expect(neighbor_coords.sort).to eq(expected.sort)
      expect(@board.live_neighbors_for(cell)).to eq(3)
    end


    it "knows neighbors for top right" do
      cell = @board.cell_at([3,0])
      neighbors = @board.neighbors_for(cell)
      neighbor_coords = neighbors.map {|cell| cell.coords }

      expected = [[2,0],[2,1],[3,1]]
      expect(neighbor_coords.sort).to eq(expected.sort)
    end
  end
end
