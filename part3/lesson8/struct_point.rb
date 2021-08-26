Point = Struct.new(:x, :y, keyword_init: true)

point = Point.new(x: 3, y: 4)

# p point.x
# p point.y

# p point['x']
# p point['y']

# p point[:x]
# p point[:y]

point.x = 5
point.y = 6
p point

point['x'] = 7
point['y'] = 8
p point

point[:x] = 9
point[:y] = 10
p point

p point.members
