require 'ostruct'

p Struct.new(:x, :y).new(3, 4) #<struct x=3, y=4>
p OpenStruct.new x: 3, y: 4    #<OpenStruct x=3, y=4>

point = OpenStruct.new x: 3, y: 3

point.x = 56
point.z = 102

p point #<OpenStruct x=56, y=3, z=102>
