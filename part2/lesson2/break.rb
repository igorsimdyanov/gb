# [*1..10].each do |i|
#   break if i > 5
#   puts i
# end

[*1..10].each do |i|
  next if i.even?
  puts i
end
