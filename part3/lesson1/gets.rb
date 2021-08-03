# File.open('hello.txt') do |file|
#   puts file.gets
#   puts file.gets
#   p file.gets
# end

# File.open('hello.txt') do |file|
#   file.each { |line| puts line }
# end

arr = File.readlines('hello.txt', chomp: true) # .map(&:chomp)
p arr
