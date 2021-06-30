# frozen_string_literal: true

print 'Input nubers: '
arr = gets.chomp

summ = arr.split(' ').map(&:to_f).sum

puts "Сумма: #{summ}"
