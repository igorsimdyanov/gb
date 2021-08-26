require 'ostruct'

point = OpenStruct.new x: 3, y: 4

# p point.x
# p point.y

# p point['x']
# p point['y']

# p point[:x]
# p point[:y]

point.z = 5
p point