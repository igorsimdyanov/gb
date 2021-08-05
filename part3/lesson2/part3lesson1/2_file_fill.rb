number = ARGV.first.to_i
abort 'Задайте количество байт' if number < 0
filename = ARGV.last
File.open(filename, 'w') do |file|
  file.write('1' * number)
end
