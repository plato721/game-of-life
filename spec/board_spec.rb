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

    it 'has a string representation' do

    end
  end
end
