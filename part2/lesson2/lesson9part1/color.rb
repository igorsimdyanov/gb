# frozen_string_literal: true

COLORS = {
  'красный' => 1,
  'оранжевый' => 2,
  'желтый' => 3,
  'зеленый' => 4,
  'голубой' => 5,
  'синий' => 6,
  'фиолетовый' => 7
}.freeze

puts "Введение название цвета (#{COLORS.keys.join(', ')})"
print '=> '
color = gets.chomp

if COLORS[color]
  puts "Вы ввели цвет номер #{COLORS[color]}"
else
  puts 'Цвет не обнаружен'
end
