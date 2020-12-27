# frozen_string_literal: true

require_relative "game_of_life/version"
require_relative "game_of_life/models/grid"
require_relative "game_of_life/models/state"
require_relative "game_of_life/actions/next_generation"
require_relative "game_of_life/actions/start_game"
require_relative "game_of_life/utils/common"
require_relative "game_of_life/views/terminal"

module GameOfLife
  def self.run
    Actions::StartGame.new.call
  end
end
