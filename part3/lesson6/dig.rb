arr = [1, [2, [3, 4]]]
# arr = [1, 2, 3, 4]
puts arr.dig(1, 1, 0) # 3
# puts arr[1][1][0]