File.open('hello.txt', 'w') do |file|
  puts file.fileno # 9
  file.puts 'Цена билета: 600'
  file.puts 'Мероприятие состоится 10.08.2021'
end
