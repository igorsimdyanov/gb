# p [1, 2, 3, 4, 5].select { |x| x.even? } # [2, 4]
arr = [1, 2, 3, 4, 5]

# p arr
# p arr.map { |x| x.even? }
# p arr.select { |x| x.even? }

p arr
p arr.map { |x| x.even? }
p arr.reject { |x| x.even? }

# p arr
# p arr.map! { |x| x.even? }
# p arr