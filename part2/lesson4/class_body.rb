class Ticket
  puts 'Начало класса Ticket'

  def event
    'Событие 1'
  end

  if RUBY_VERSION == '3.0.0'
    def event
      'Событие 2'
    end
  end

  puts 'Завершение класса Ticket'
end

ticket = Ticket.new
puts ticket.event
