# GameOfLife

The Game of Life, also known simply as Life, is a cellular automaton devised by the British mathematician John Horton
Conway in 1970. The “game” is a zero-player game, meaning that its evolution is determined by its initial state,
requiring no further input. One interacts with the Game of Life by creating an initial configuration and observing how
it evolves.

The implementation pattern used on this game is inspired in Redux.

## Installation

1. From the root folder execute:

       $ bundle install

2. Build the gem:

       $ gem build game_of_life.gemspec

3. Install :

       $ gem install game_of_life-1.0.0.gem


## Usage

You can start it on any computer where Ruby is installed by executing the command irb from your command line interface

    $ irb

require the gem and you are ready to start a new game. 

```ruby
require "game_of_life"
 

Actions::StartGame.new.call
```

## Demo
![preview](https://user-images.githubusercontent.com/47440/103113227-a06e4600-460e-11eb-9a8f-192fb5dbd4f9.gif)