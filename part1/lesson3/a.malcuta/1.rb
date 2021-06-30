#Задание 1
class Ticket
  def price
    '3500'
  end

  def row
    '4'
  end

  def seat
    '12'
  end

  def event
    'Фильм - Трудно быть рубистом'
  end
end

ticket = Ticket.new

puts ticket.class
puts ticket.price # puts(puts('3500'))
puts ticket.row
puts ticket.seat
puts ticket.event
