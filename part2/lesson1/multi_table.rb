# frozen_string_literal: true

print 'Пожалуйста, введите максимальное значение: '
number = gets.to_i
j = 1

size_number = (number * number).to_s.size + 1

while j <= number
  i = 1
  while i <= number
    print format("% #{size_number}d", i * j)
    i += 1
  end
  j += 1
  puts
end
