# frozen_string_literal: true

RSpec.describe Actions::StartGame do
  let(:start_game_action) { described_class.new }

  describe "#initialize" do
    it "should invoke Models::State.initial" do
      expect(Models::State).to receive(:initial)
      described_class.new
    end
  end

  describe "#call" do
    it "should invoke run!" do
      expect(start_game_action).to receive(:run!)
      start_game_action.call
    end
  end

  describe "#animate_transition" do
    after(:example) do
      start_game_action.send(:animate_transition)
    end

    it "should invoke sleep with proper arg" do
      expect(start_game_action).to receive(:sleep).with(kind_of(Numeric))
    end

    it "should invoke print_to_terminal" do
      expect(start_game_action).to receive(:print_to_terminal)
    end
  end

  describe "#print_to_terminal" do
    it "should invoke Views::Terminal.new with proper initial_state_grid arg" do
      initial_state_grid = start_game_action.instance_variable_get(:@state).grid
      view_terminal = Views::Terminal.new(initial_state_grid)
      expect(Views::Terminal).to receive(:new).with(initial_state_grid).and_return(view_terminal)

      start_game_action.send(:print_to_terminal)
    end

    it "should invoke Views::Terminal.call" do
      initial_state_grid = start_game_action.instance_variable_get(:@state).grid
      view_terminal = Views::Terminal.new(initial_state_grid)
      allow(Views::Terminal).to receive(:new).and_return(view_terminal)
      expect(view_terminal).to receive(:call)

      start_game_action.send(:print_to_terminal)
    end
  end

  describe "#generate_next_generation!" do
    let!(:initial_state_grid) { start_game_action.instance_variable_get(:@state).grid }
    let(:action_next_generation) { Actions::NextGeneration.new(initial_state_grid) }

    after(:example) do
      start_game_action.send(:generate_next_generation!)
    end

    it "should invoke Actions::NextGeneration.new with proper initial_state_grid arg" do
      expect(Actions::NextGeneration).to receive(:new).with(initial_state_grid).and_return(action_next_generation).once
    end

    it "should invoke Actions::NextGeneration.call" do
      allow(Actions::NextGeneration).to receive(:new).with(initial_state_grid).and_return(action_next_generation)
      expect(action_next_generation).to receive(:call).once
    end
  end

end
