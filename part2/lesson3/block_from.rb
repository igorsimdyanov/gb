# loop { puts 'Hello, world' }
# loop do
#   puts 'Hello, world'
# end

p [1, 2, 3, 4, 5].map { |x| x * x}
p [1, 2, 3, 4, 5].map do |x|
  x * x
end