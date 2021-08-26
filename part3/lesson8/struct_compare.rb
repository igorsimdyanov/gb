Point = Struct.new(:x, :y)

p Point.new(3, 4) == Point.new(3, 4)
p Point.new(3, 4) == Point.new(4, 3)
