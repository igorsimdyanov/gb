# frozen_string_literal: true

require_relative 'lib/color'

puts 'Введите название цвета (для оставноки введите stop) '
p Color.list.uniq.reject(&:empty?).sort
