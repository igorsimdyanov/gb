class Ticket
  def initialize(price, date)
    @price = price
    @date = date
  end

  attr_reader :price, :date
end

ticket = Ticket.new(500, Time.mktime(2021, 8, 17, 10, 10))
p ticket.price
p ticket.methods.size
