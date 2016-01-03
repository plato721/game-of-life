# Conway's Game of Life
[Wikipedia Description](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)

This is a ruby implementation of Conway's game of life. To run it, install ruby, then:

```
irb
load 'lib/game.rb'
game = Game.new
game.play
```

Without passing game a parameter, a random 15x15 board is generated. A pattern parameter can be passed in like:

```
my_pattern = <<-EOF
-*--
**--
-*-*
*-**
EOF

game = Game.new(pattern: my_pattern)
```

The board will refresh every 0.25 seconds until a regeneration would yield the same board.

There's some repitition and test lapses in the source, but I think this is a decent starting point.
