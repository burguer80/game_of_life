# frozen_string_literal: true

RSpec.describe GameOfLife do
  it "has a version number" do
    expect(GameOfLife::VERSION).not_to be nil
  end

  it "Should invoke Actions::StartGame.new and call methods" do
    start_game_action = Actions::StartGame.new
    expect(Actions::StartGame).to receive(:new).and_return(start_game_action)
    expect(start_game_action).to receive(:call)

    described_class.run
  end
end
