# frozen_string_literal: true

arr = ['Цена билета: 600', 'Мероприятие состоится 10.08.2021',
       '1', '2', '3', '3', '3']

File.write('hello_from_array.txt', arr.join("\n"))
