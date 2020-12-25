module Models
  class State < Struct.new(:grid)
    def self.initial
      grid_initial_state = Models::Grid.new
      Models::State.new(grid_initial_state)
    end
  end
end