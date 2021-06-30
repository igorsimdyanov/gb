# def convert
#   5 * 1000
# end
# def convert = 5 * 1000
#'hello' => ruby

#puts convert

def convert(value, factor = 1000)
  value * factor
end

puts convert(12)
puts convert(12, 1024)
