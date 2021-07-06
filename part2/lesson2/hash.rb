rainbow = %w[red orange yellow green blue indigo violet]

# for color in rainbow
#   puts color
# end

rainbow.each { |color| puts color }

rainbow = {
  red: 'красный',
  orange: 'оранжевый',
  yellow: 'желтый',
  green: 'зеленый',
  blue: 'голубой',
  indigo: 'синий',
  violet: 'фиолетовый'
}

rainbow.each { |key, value| puts "#{key}: #{value}" }
