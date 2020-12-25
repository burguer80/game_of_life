# frozen_string_literal: true

RSpec.describe Models::State do
  describe ".initial" do
    after(:example) do
      described_class.initial
    end

    it "should invoke Models::Grid.new" do
      expect(Models::Grid).to receive(:new)
    end

    it "should invoke Models::State.new with grid_initial_state arg" do
      grid_initial_state = Models::Grid.new
      allow(Models::Grid).to receive(:new).and_return(grid_initial_state)
      expect(Models::State).to receive(:new).with(grid_initial_state)
    end
  end
end
