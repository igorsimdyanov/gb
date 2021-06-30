# def convert(value, factor = nil)
#   return value * 1_000 unless factor
#   value * factor
# end

# puts convert(11)
# puts convert(11, 1_024)

def number(x)
  [x, x * x, x ** 0.5]
end

original, square, sqrt = number(7)
puts original
puts square
puts sqrt
