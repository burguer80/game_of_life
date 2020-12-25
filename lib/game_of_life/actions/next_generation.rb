module Actions
  class NextGeneration

    def initialize(grid)
      @grid = grid
    end

    def call
      regenerate!
      @grid
    end

    private

    def regenerate!
      @grid.cells = compute_next_generation
    end

    def compute_next_generation
      next_generation = @grid.empty_cells
      @grid.cells.each_with_index do |row, row_index|
        row.each_index do |col_index|
          next_generation[row_index][col_index] = @grid.compute_cell(row_index, col_index)
        end
      end
      next_generation
    end
  end
end