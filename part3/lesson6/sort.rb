p [6, 2, 8, 3, 9, 11, 1].sort
arr = %w[second third fst]
p arr.sort { |a, b| a.size <=> b.size }
p arr.sort_by(&:size)

# лунь
# нуль
# 'лунь'.split('').sort == 'нуль'.split('').sort