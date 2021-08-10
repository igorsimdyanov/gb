# frozen_string_literal: true

require_relative 'vector/point'

# Vector class
class Vector
  attr_accessor :x1, :y1, :x2, :y2

  def initialize(x1, y1, x2, y2)
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
  end

  def distance
    Math.sqrt((x2 - x1)**2 + (y2 - y1)**2)
  end
end
