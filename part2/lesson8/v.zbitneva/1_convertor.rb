# frozen_string_literal: true

require_relative 'lib/integer'

print 'Введите число: '
num = gets.to_i.abs

puts "#{num} Кб равен #{num.kilobytes} байтам"
puts "#{num} Мб равен #{num.megabytes} байтам"
puts "#{num} Гб равен #{num.gigabytes} байтам"
puts "#{num} Тб равен #{num.terabytes} байтам"
