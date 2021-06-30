var = 'Hello, world!'
var = 1
var = 1..10
var = Object

klass = case var
        when Integer
          'Целое число'
        when String
          'Строка'
        when Range
          'Диапазон'
        else
          'Какой-то класс'
        end

puts klass
