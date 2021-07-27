class Ticket
  remove_method :new
  def initialize(date:, price: 500)
    @date = date
    @price = price
  end

  def price
    @price
  end

  def date
    @date
  end
end

ticket = Ticket.new date: Time.new

p ticket.price
p ticket.date

class Ticket
  # remove_method :price
  # undef_method :date
end

p ticket.price
p ticket.date
