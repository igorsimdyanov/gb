# истина это true все кроме false, nil
if Object
  puts 'класс'
end

if Object.new
  puts 'объект'
end

if nil
  puts 'Ничего не выводится'
end

if puts 'Эта строка вывется'
  puts 'А эта - нет'
end
