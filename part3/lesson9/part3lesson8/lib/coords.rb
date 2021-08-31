# frozen_string_literal: true

# 10x10 coords generator
class Coords
  @coords = []
  MAX_ATTEMPT = 5

  class << self
    def generate
      MAX_ATTEMPT.times do
        xy = xy_coords
        next if @coords.include? xy

        @coords << xy
        return xy
      end
      raise 'Max trys has reached'
    end

    private

    def xy_coords
      [rand_value, rand_value]
    end

    def rand_value
      rand(1..10)
    end
  end
end
