# frozen_string_literal: true

print 'Пожалуйста, введите количество повторов '
max_iterates = gets.to_i
i = 0

while i < max_iterates
  puts i
  redo if rand(0..1).zero?
  i += 1
end
