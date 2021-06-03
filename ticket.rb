class Ticket
  def date
    '04.06.2021'
  end

  def price
    3500
  end

  # TODO
  # Название фильма
  # Место
  # Ряд
end

ticket = Ticket.new
p 'Дата фильма: ' + ticket.date
p 'Стоимость фильма: ' + ticket.price.to_s
