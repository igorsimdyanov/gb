arr = [1, 2, 3, 4].map do |val|
 val + 1
end
p arr # [2, 3, 4, 5]

arr = []
for val in [1, 2, 3, 4]
  arr << val + 1
end
p arr
