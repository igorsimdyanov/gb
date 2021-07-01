# frozen_string_literal: true

def convert(*values)
  j = 0
  while j < values.size
    values[j] = values[j] * 1000
    j += 1
  end

  values
end

print 'Введите последовательность чисел (11 7 5 3...) '
arr = gets.chomp.split(/\s+/)
i = 0
while i < arr.size
  arr[i] = arr[i].to_i
  i += 1
end
p arr # [11, 7, 5, 3]
p convert(*arr) # puts convert(11, 7, 5, 3)
