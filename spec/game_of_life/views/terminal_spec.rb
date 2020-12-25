# frozen_string_literal: true

RSpec.describe Views::Terminal do
  let!(:view_terminal) do
    initial_state = Models::State.initial
    grid_initial_state = initial_state.grid
    described_class.new(grid_initial_state)
  end

  describe "#call" do
    after(:example) do
      view_terminal.call
    end

    it "should invoke print_to_terminal method" do
      expect(view_terminal).to receive(:print_to_terminal).once
    end

    it "should invoke clear_screen method " do
      expect(view_terminal).to receive(:clear_screen).once
    end
  end

  describe "#clear_screen" do
    it "should invoke $stdout.flush" do
      expect($stdout).to receive(:flush).once
      view_terminal.send(:clear_screen)
    end
  end

  describe "#print_to_terminal" do
    let!(:grid_size) { view_terminal.grid.size }

    it "should invoke print_cell_status at least once with the proper args" do
      amount_of_total_cells = grid_size ** 2
      expect(view_terminal).to receive(:print_cell_status).exactly(amount_of_total_cells).with(eq(0) | eq(1))
      view_terminal.send(:print_to_terminal)
    end

    it "should invoke $stdout.print at least once with the proper args" do
      allow(view_terminal).to receive(:print_cell_status)
      expect($stdout).to receive(:print).exactly(grid_size).with("\n")
      view_terminal.send(:print_to_terminal)
    end
  end

  describe "#print_cell_status" do
    cell_status = nil

    after(:example) do
      expect(view_terminal).to receive(:build_cell_body).once.with(eq(0) | eq(1))
      expect($stdout).to receive(:print).once
      view_terminal.send(:print_cell_status, cell_status)
    end

    it "should invoke $stdout.print once an build_cell_body with zero" do
      cell_status = 0
    end

    it "should invoke $stdout.print once an build_cell_body with 1" do
      cell_status = 1
    end
  end

  describe "#build_cell_body" do
    cell_status = nil
    expected_cell_body = nil

    after(:example) do
      cell_body = view_terminal.send(:build_cell_body, cell_status)
      expect(cell_body).to eq(expected_cell_body)
    end

    it "should return the proper cell_body if the cell status is 1" do
      cell_status = 1
      expected_cell_body = "o"
    end

    it "should return the proper cell_body if the cell status is 0" do
      cell_status = 0
      expected_cell_body = " "
    end
  end

end
