class Ticket
  def initialize(date:, price: 500)
    @price = price
    @date = date
  end

  def date
    @date
  end

  def price
    price_format(@price)
  end

  private

  def price_format(price)
    format('Цена билета %d', price)
  end
end

ticket = Ticket.new date: Time.mktime(2021, 7, 29, 10, 10)
puts ticket.date
puts ticket.price
