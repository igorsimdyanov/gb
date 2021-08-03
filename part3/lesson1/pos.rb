File.open('hello.txt', 'w') do |file|
  puts file.pos # 0
  file.puts 'Цена билета: 600'
  puts file.pos # 27
  file.puts 'Мероприятие состоится 10.08.2021'
  puts file.pos # 80
end