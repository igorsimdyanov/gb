# frozen_string_literal: true

print 'Пожалуйста, введите количество повторов '
max_iterates = gets.to_i
i = 0

while i < max_iterates
  i += 1
  next if i.odd?

  puts i
end
