# arr = [1, 2, 3, 4, 5]
# arr.each { |x| puts x + 1 }
# p arr

# rainbow = %w[red orange yellow green blue indigo violet]
# rainbow.each_with_index { |color, i| puts "#{i + 1}: #{color}" }

arr = [1, 2, 3, 4, 5]
# result = arr.map { |x| x + 1 }
result = arr.map { |x| x + 1 }
p result # [2, 3, 4, 5, 6]
p arr    # [1, 2, 3, 4, 5]

result = arr.map! { |x| x + 1 }
p result # [2, 3, 4, 5, 6]
p arr    # [2, 3, 4, 5, 6]
