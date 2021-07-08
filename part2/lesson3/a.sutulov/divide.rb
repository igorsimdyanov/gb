# frozen_string_literal: true

require_relative 'lib/inputs'

puts 'Введите числитель: '
numerator = gets.to_f
num = Input.new.denominator
puts "#{numerator} / #{num} = #{(numerator / num).round(1)}"
