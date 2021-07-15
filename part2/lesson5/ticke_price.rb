class Ticket
  def initialize(date:, price: 500)
    @price = price
    @date = date
  end
 
  def price
    @price
  end

  def date
    @date
  end
end

first = Ticket.new(date: Time.mktime(2021, 7, 16, 10, 20))
second = Ticket.new(date: Time.mktime(2021, 7, 16, 10, 20), price: 600)

puts first.price # 500
puts first.date
puts second.price # 600
puts second.date
