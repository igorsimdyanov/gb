# frozen_string_literal: true

# Класс для координат корабликов
class Coord
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def ==(other)
    [x, y] == [other.x, other.y]
  end
end
