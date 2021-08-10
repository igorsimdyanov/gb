# frozen_string_literal: true

class Vector
  # Two dimension point
  class Point
    attr_accessor :x, :y

    def initialize(x:, y:)
      @x = x
      @y = y
    end
  end
end
