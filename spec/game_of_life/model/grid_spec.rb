# frozen_string_literal: true

RSpec.describe Models::Grid do
  let!(:cell_row) { 1 }
  let!(:cell_col) { 1 }
  let!(:mocked_cells) do
    [[0, 1, 0],
     [0, 1, 0],
     [1, 1, 1]]
  end
  let(:grid) { described_class.new }

  describe "#initialize" do
    it "should be default size value when class is instantiated" do
      expect(grid.size).to eq(50)
    end

    it "should return two dimensional array" do
      expect(grid.cells).to be_an_instance_of(Array)
      expect(grid.cells[0]).to be_an_instance_of(Array)
    end

    it "should invoke build_cells method" do
      expect(grid).to receive(:build_cells).once
      grid.send(:initialize)
    end
  end

  describe "#count_neighbours" do
    it "should invoke cells_near_by method with proper cell_row and cell_col args" do
      sum_of_near_by_cells = 0
      expect(grid).to receive(:cells_near_by).with(cell_row, cell_col).and_return(sum_of_near_by_cells)
      grid.count_neighbours(cell_row, cell_col)
    end

    it "should the proper count of neighbours" do
      expected_count_neighbours = 4
      grid.instance_variable_set(:@cells, mocked_cells)
      count_neighbours = grid.count_neighbours(cell_row, cell_col)
      expect(count_neighbours).to eq(expected_count_neighbours)
    end

  end

  describe "#cells_near_by" do
    it "should invoke get_neighbour_reference method with proper args" do
      min_grid_locations = -1
      max_grid_locations = 1
      expect(grid).to receive(:get_neighbour_reference).with(be_between(0, grid.cells.size),
                                                             be_between(min_grid_locations, max_grid_locations))
                                                       .at_least(:once).and_return(1)

      grid.cells_near_by(1, 1)
    end

    it "should return the proper amount of cells near by" do
      grid.instance_variable_set(:@cells, mocked_cells)
      expected_cells_near_by = 5
      cells_near_by = grid.cells_near_by(cell_row, cell_col)
      expect(cells_near_by).to eq(expected_cells_near_by)
    end
  end

  describe "#compute_cell" do
    it "should invoke count_neighbours with proper row and col arg" do
      expect(grid).to receive(:count_neighbours).with(cell_row, cell_col).and_return(0)
      grid.compute_cell(cell_row, cell_col)
    end

    context "Functional Requirements" do
      live_neighbours_count = nil
      expected_cell_status = nil

      after(:example) do
        grid.instance_variable_set(:@cells, mocked_cells)
        expect(grid).to receive(:count_neighbours).with(cell_row, cell_col).and_return(live_neighbours_count)
        cell_status = grid.compute_cell(cell_row, cell_col)
        expect(cell_status).to eq(expected_cell_status)
      end

      context "Any living cell with fewer than two live neighbours dies, as if caused by underpopulation." do
        after(:example) do
          mocked_cells[cell_row][cell_col] = expected_cell_status
        end

        it "should return 0 if the cell status is 1 and has less than 2 live neighbours" do
          live_neighbours_count = 1
          expected_cell_status = 0
        end
      end

      context "Any living cell with more than three live neighbours dies, as if by overcrowding." do
        it "should return 0 if the cell status is 1 and has more than 3 live neighbours" do
          live_neighbours_count = 4
          expected_cell_status = 0
        end
      end

      context "Any living cell with two or three live neighbours lives on to the next generation." do
        it "should return 1 if the cell status is 1 and has 2 live neighbours" do
          live_neighbours_count = 2
          expected_cell_status = 1
        end
        it "should return 1 if the cell status is 1 and has 3 live neighbours" do
          live_neighbours_count = 3
          expected_cell_status = 1
        end
      end

      context "Any dead cell with exactly three live neighbours becomes a live cell." do
        it "should return 1 if the cell status is 0 and has 3 live neighbours" do
          live_neighbours_count = 3
          expected_cell_status = 1
        end
      end
    end

  end

  describe "#empty_cells" do
    it 'should invoke build_cells with proper empty arg' do
      expect(grid).to receive(:build_cells).with(true)
      grid.empty_cells
    end
  end

  describe "#build_cells" do
    it 'should invoke Utils::Common.build_2d_array with proper default_empty_arg true args' do
      empty_arg = true
      expect(Utils::Common).to receive(:build_2d_array).with(grid.size, grid.size, empty_arg)
      grid.send(:build_cells, empty_arg)
    end

    it 'should invoke Utils::Common.build_2d_array with default empty false_arg' do
      default_empty_arg = false
      expect(Utils::Common).to receive(:build_2d_array).with(grid.size, grid.size, default_empty_arg)
      grid.send(:build_cells)
    end
  end

  describe "#get_neighbour_reference" do
    it 'should return the proper neighbour cell reference' do
      expected_neighbour = 2
      grid.instance_variable_set(:@size, 10)
      neighbour_col = grid.send(:get_neighbour_reference, 1, 1)
      expect(neighbour_col).to eq(expected_neighbour)
    end
  end

end
