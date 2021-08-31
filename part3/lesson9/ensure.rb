def say
  raise 'Ошибка' if rand(2).zero?
rescue
  puts 'Только в случае ошибки'
# ensure
#   puts 'Выполняется всегда'
else
  puts 'Только в случае успеха'
end

say
