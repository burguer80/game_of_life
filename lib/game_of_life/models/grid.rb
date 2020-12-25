module Models
  class Grid
    attr_accessor :cells
    attr_reader :size

    def initialize(size = 50)
      # TODO: Implement Error handling
      return false unless size.positive?
      @size = size
      @cells = build_cells
    end

    def count_neighbours(cell_row, cell_col)
      current_cell = cells[cell_row][cell_col] || 0
      cells_near_by(cell_row, cell_col) - current_cell
    end

    def cells_near_by(cell_row, cell_col)
      sum = 0
      near_by_grid_locations = -1..1
      near_by_grid_locations.each do |grid_col|
        near_by_grid_locations.each do |grid_row|
          neighbour_col = get_neighbour_reference(cell_col, grid_col)
          neighbour_row = get_neighbour_reference(cell_row, grid_row)
          sum += cells[neighbour_row][neighbour_col] || 0
        end
      end
      sum
    end

    def compute_cell(row, col)
      cell_status = cells[row][col]
      neighbours = count_neighbours(row, col)

      # 🔎 rules of life
      return 1 if cell_status.zero? && neighbours == 3
      return 0 if cell_status == 1 && (neighbours < 2 || neighbours > 3)

      cell_status
    end

    def empty_cells
      build_cells(true)
    end

    private

    def build_cells(empty = false)
      Utils::Common.build_2d_array(size, size, empty)
    end

    def get_neighbour_reference(cell_location, neighbour_location)
      (cell_location + neighbour_location + size) % size
    end
  end
end