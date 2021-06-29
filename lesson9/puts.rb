# puts 'hello', 'ruby', 'world'

# def multi_params(x, y, *params)
#   p x # 1
#   p y # 2
#   p params # [3, 4]
# end

# multi_params(1, 2, 3, 4)

def array_params(x, y, z)
  p x
  p y
  p z
end

point = [6, 3, 2]
array_params(*point)
# array_params(point.first, point[1], point.last)
