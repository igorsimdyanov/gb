# if RUBY_VERSION == '3.0.0'
#   puts 'Корректная версия Ruby'
# elsif RUBY_VERSION == '2.7.0'
#   puts 'Проблемная версия Ruby'
# else
#   puts 'Некорректная версия Ruby'
# end

case RUBY_VERSION
when '3.0.0'
  puts 'Корректная версия Ruby'
when '2.7.0'
  puts 'Проблемная версия Ruby'
else
  puts 'Некорректная версия Ruby'
end

# if RUBY_VERSION === '3.0.0'
#   puts 'Корректная версия Ruby'
# elsif RUBY_VERSION === '2.7.0'
#   puts 'Проблемная версия Ruby'
# else
#   puts 'Некорректная версия Ruby'
# end
