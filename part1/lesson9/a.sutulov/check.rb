# frozen_string_literal: true

print 'Введите аргумент: '
input = gets.chomp
res = if input.to_i.to_s != input && input.to_f.to_s != input
       'Строка'
     elsif input.include?('.')
       'Вещественное число'
     else
       'Целое число'
     end

puts res # 3.0e-2
