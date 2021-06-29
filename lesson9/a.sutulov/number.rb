# frozen_string_literal: true

print 'Введите три целых числа: '
num = gets
if num.include? '.'
  puts 'Вы ввели не целое число!'
else
  arr = num.split(' ').map(&:to_i)
  puts arr.max
end
