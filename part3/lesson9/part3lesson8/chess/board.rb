# frozen_string_literal: true

# Расстановка ферзей по шахматной доске
class Board
  attr_accessor :coords

  MAX_POSITION = 8

  def initialize
    @coords = Array.new(MAX_POSITION) { |_i| Array.new(MAX_POSITION, 0) }
  end

  def to_s
    result = []
    coords_range.each do |y|
      line = []
      coords_range.each do |x|
        line << coords[x][y]
      end
      result << line.join(' ')
    end
    result.join("\n")
  end

  # Можем в эту точку поставить ферзя?
  def check?(x, y)
    coords[x][y] <= 0
  end

  # Отмечаем позиции, находящиеся по боем ферзя
  def set_queen(x, y)
    return if y >= MAX_POSITION && x >= MAX_POSITION
    return unless check?(x, y)

    coords_range.each do |i|
      horizontal(y, i)
      vertical(x, i)
      left_right(x, y, i)
      right_left(x, y, i)
    end
  end

  private

  def coords_range
    @coords_range ||= 0...MAX_POSITION
  end

  module UnderAttack
    def horizontal(y, i)
      coords[i][y] += 1
    end

    def vertical(x, i)
      coords[x][i] += 1
    end

    def left_right(x, y, i)
      coords[i][y - x + i] += 1 if coords_range.include? y - x + i
    end

    def right_left(x, y, i)
      coords[i][y + x - i] += 1 if coords_range.include? y + x - i
    end
  end
  include UnderAttack
end
