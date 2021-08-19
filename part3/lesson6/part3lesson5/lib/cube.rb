# frozen_string_literal: true

# Cube class
# rubocop:disable Naming/MethodParameterName, Style/ClassVars
class Cube
  attr_accessor :x, :y, :z, :size

  @@list = {}

  def self.instance(x, y, z, size)
    key = [x, y, z, size]
    instance = @@list[key]
    unless instance
      @@list[key] = new(x, y, z, size)
      instance = @@list[key]
    end
    instance
  end

  def initialize(x, y, z, size)
    @x = x
    @y = y
    @z = z
    @size = size
  end

  def volume
    size**3
  end

  private_class_method :new
end
# rubocop:enable Naming/MethodParameterName, Style/ClassVars
