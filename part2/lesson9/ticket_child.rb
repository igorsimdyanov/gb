require_relative 'ticket_methods'

class TicketChild < Ticket

  def price_format(price)
    format('Цена билета %d', price)
  end

  def number
    super
  end
end

fst = TicketChild.new(date: Time.mktime(2021, 7, 30, 10, 20))
snd = TicketChild.new(date: Time.mktime(2021, 7, 30, 10, 20))

puts fst <=> snd
puts fst.price
puts fst.number
puts fst.price_format(600)
