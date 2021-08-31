# frozen_string_literal: true

require_relative 'coord'
require_relative 'field'

# Класс кораблей
class Ship
  MIN_DECKS = 1
  MAX_DECKS = 4

  attr_reader :size, :coordinates

  def initialize(decks)
    @coordinates = []
    @size = decks
    fill_ship_coords
  end

  def fill_ship_coords
    i = 0
    x, y = rand_xy
    # false - кораблик будет расположен вдоль оси X
    # true - кораблик будет расположен вдоль оси Y
    direction = [true, false].sample
    loop do
      add_coord(create_coord(x, y, direction, i))
      break if i == size - 1

      i += 1
    end
  end

  private

  def size=(size)
    raise 'Неверное количество палуб' unless (MIN_DECKS..MAX_DECKS).cover?(size)

    @size = size
  end

  def add_coord(new_value)
    @coordinates.push(new_value)
  end

  def create_coord(x, y, direction, i)
    x += i * (direction ? 0 : 1)
    y += i * (direction ? 1 : 0)
    Coord.new(x, y)
  end

  def rand_xy
    [rand(1..Field::MAX_X), rand(1..Field::MAX_Y)]
  end
end
