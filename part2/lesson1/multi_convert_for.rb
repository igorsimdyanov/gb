# frozen_string_literal: true

def convert(*values)
  j = 0
  for x in values
    values[j] = x.to_i * 1000
    j += 1
  end

  values
end

print 'Введите последовательность чисел (11 7 5 3...) '
arr = gets.chomp.split(/\s+/)
p arr
p convert(*arr)
