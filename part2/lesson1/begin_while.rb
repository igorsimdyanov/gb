# frozen_string_literal: true

print 'Пожалуйста, введите количество повторов '
max_iterates = gets.to_i
i = 0

begin
  puts "#{i + 1} Hello, world!"
  i += 1
end while i < max_iterates
