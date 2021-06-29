# frozen_string_literal: true

require_relative 'lib/week'

print 'Введите номер: '
number = gets.to_i
puts Week.new.find_right(number)
