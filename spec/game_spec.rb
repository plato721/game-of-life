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
end
