# frozen_string_literal: true

print 'Введите целое число: '
number = gets.chomp
puts(if number.to_i.to_s != number
       'Это не целое число!'
     elsif number.to_i.even?
       'Число чётное!'
     else
       'Число не чётное!'
     end)
