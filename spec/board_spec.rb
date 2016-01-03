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

  it "knows neighbors for a cell" do
    pattern = <<-EOF
-*--
**--
-*-*
*-**
EOF
    board = Board.new(pattern: pattern, height: 4, length: 4)

    cell = board.cell_at([2,2])
    neighbors = board.neighbors_for(cell)
    neighbor_coords = neighbors.map {|cell| cell.coords }

    expected = [[1,1], [2,1], [3,1], [1,2], [3,2], [1,3], [2,3], [3,3]].sort
    expect(neighbor_coords.sort).to eq(expected.sort)
  end
end
