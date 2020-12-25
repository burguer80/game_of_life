# frozen_string_literal: true
# TODO: Add negative scenarios

RSpec.describe Actions::NextGeneration do
  let!(:next_generation_action) do
    initial_state = Models::State.initial
    grid_initial_state = initial_state.grid
    described_class.new(grid_initial_state)
  end

  describe "#initialize" do
    it "should contain an instance of Models::Grid after initialization" do
      grid = next_generation_action.instance_variable_get(:@grid)
      expect(grid).to be_an_instance_of(Models::Grid)
    end
  end

  describe "#call" do
    it "should invoke regenerate!" do
      expect(next_generation_action).to receive(:regenerate!).once
      next_generation_action.call
    end
  end

  describe "#compute_next_generation" do
    xit("it should invoke Models::Grid.compute_cell with proper args")
    xit("it should next_generation properly")
  end

end
