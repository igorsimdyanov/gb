# frozen_string_literal: true

print 'Пожалуйста, введите количество повторов: '
max_iterates = gets.to_i
i = 0

# until i >= max_iterates # 0 >= 0
#   puts "#{i + 1} Hello, world!"
#   i += 1
# end

until i >= max_iterates
  puts "#{i + 1} Hello, world!"
  i += 1
  break if i >= max_iterates
end
