# frozen_string_literal: true

require_relative 'ships'
require_relative 'ship'

# Игровое поле
class Field
  MAX_X = 10
  MAX_Y = 10
  attr_accessor :field

  def initialize
    @field = Array.new(MAX_Y) { Array.new(MAX_X) }
    @letters = ('A'..'J').to_a
  end

  def print_field
    print_letters
    puts
    i = 1
    field.each do |line|
      print format('%2i', i)
      print_line(line)
      puts
      i += 1
    end
  end

  def add_ship(ship)
    ship.coordinates.each do |coord|
      @field[coord.x - 1][coord.y - 1] = ship
    end
  end

  def touch_another_ship?(ship)
    -1.upto(1) do |dx|
      -1.upto(1) do |dy|
        ship.coordinates.each do |ship_coord|
          x = ship_coord.x + dx - 1
          y = ship_coord.y + dy - 1
          return true if anybody_here?(x, y)
        end
      end
    end
    false
  end

  def out_of_field?(ship)
    ship.coordinates.last.x > MAX_X || ship.coordinates.last.y > MAX_Y
  end

  def anybody_here?(x, y)
    return true if (0...MAX_X).include?(x) && (0...MAX_Y).include?(y) && (@field[x][y])
  end

  def print_letters
    print ' '
    @letters.each { |i| print format('%3s', i) }
  end

  def print_line(line)
    line.each { |cell| print_symbol(cell) }
  end

  def print_symbol(c)
    print (c ? ' O ' : ' . ').white.on.blue
  end
end
