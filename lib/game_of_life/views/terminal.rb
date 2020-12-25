# frozen_string_literal: true

module Views

  class Terminal < Struct.new(:grid)

    def call
      clear_screen
      print_to_terminal
    end

    private

    CELL_BODY = "o"
    CELL_EMPTY = " "

    def clear_screen
      $stdout.flush
    end

    def print_to_terminal
      grid.cells.each do |row|
        row.each do |cell_status|
          print_cell_status(cell_status)
        end
        $stdout.print "\n"
      end
    end

    def print_cell_status(cell_status)
      $stdout.print build_cell_body(cell_status)
    end

    def build_cell_body(cell_status)
      cell_status.positive? ? CELL_BODY : CELL_EMPTY
    end

  end
end
