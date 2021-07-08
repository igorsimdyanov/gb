hello = 'Hello, %s!'.yield_self do |str|
          print 'Пожалуйста, введите имя '
          format(str, gets.chomp)
        end

puts hello
