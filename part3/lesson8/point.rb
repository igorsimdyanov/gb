class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
end

fst = Point.new(3, 4)
snd = Point.new(-1, 5)

p fst
p snd
