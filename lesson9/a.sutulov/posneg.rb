# frozen_string_literal: true

print 'Введите число: '
number = gets.chomp
puts(if number.to_i.to_s != number && number.to_f.to_s != number
       'Это не число!'
     elsif number.first != '-'
       'Положительное число'
     else
       'Отрицательное число'
     end)
