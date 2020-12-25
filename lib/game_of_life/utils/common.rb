# frozen_string_literal: true

module Utils
  class Common
    def self.build_2d_array(rows, cols, empty= false)
      Array.new(rows) { Array.new(cols) { empty ? nil : rand(2) } }
    end
  end
end
