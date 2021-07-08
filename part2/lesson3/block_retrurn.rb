def greeting
  name = block_given? ? yield : 'world'
  "Hello, #{name}!"
end

puts greeting
puts greeting { 'Ruby' }

# name = greeting do
#   print 'Пожалуйста, введите имя '
#   gets.chomp
# end

# puts name

puts greeting {
  print 'Пожалуйста, введите имя '
  gets.chomp
}
