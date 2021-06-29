# frozen_string_literal: true

require_relative './lib/colors'

print 'Введите номер цвета: '
number = gets.to_i
puts Colors.new.find_right(number)
