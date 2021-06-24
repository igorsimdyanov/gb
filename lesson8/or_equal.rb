# item = item || 'world'
item = 'ruby'
item ||= 'world'

puts "Hello, #{item}!" # Hello, world!

item ||= begin
  x = 12 - 5
  y = 15 - 2
  sum = x * x + y * y
  sum ** 0.5
end
