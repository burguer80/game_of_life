module Actions
  class StartGame
    def initialize
      @state = Models::State.initial
    end

    def call
      run!
    end

    private

    FRAME_REFRESH_DELAY = 0.3

    def animate_transition
      sleep FRAME_REFRESH_DELAY
      print_to_terminal
    end

    def print_to_terminal
      Views::Terminal.new(@state.grid).call
    end

    def generate_next_generation!
      @state.grid = Actions::NextGeneration.new(@state.grid).call
    end

    def run!
      loop do
        generate_next_generation!
        animate_transition
      end
    end
  end
end