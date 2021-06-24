# p (if RUBY_VERSION == '3.0.0'
#      'Содержимое if-конструкции'
#    end)

var = if RUBY_VERSION == '3.0.0'
        'Корректная версия'
      else
        'Некорректная версия'
      end

puts var
