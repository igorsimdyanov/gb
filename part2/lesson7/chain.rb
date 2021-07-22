class Ticket
  attr_accessor :price, :can_buy

  def initialize(price:)
    @price = price
    @can_buy = true
  end

  def buy
    @can_buy = false
    self
  end
end

ticket = Ticket.new price: 600
p ticket.buy.price
