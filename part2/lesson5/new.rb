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

# def new
#   allocate
#   initialize
# end

ticket = Ticket.allocate
p ticket.price # nil
