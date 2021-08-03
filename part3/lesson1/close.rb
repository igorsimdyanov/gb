file = File.new('hello.txt', 'w')
puts file.fileno # 9
file.puts 'Цена билета: 600'
file.puts 'Мероприятие состоится 10.08.2021'
file.close

other = File.new('another.txt', 'w')
puts other.fileno # 9
# other.close
