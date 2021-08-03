file = File.new('hello.txt', 'w')
file.puts 'Цена билета: 600'
file.puts 'Мероприятие состоится 10.08.2021'
puts STDIN.fileno
puts STDOUT.fileno
puts STDERR.fileno
puts file.fileno
