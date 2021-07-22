class Ticket
  attr_accessor :price

  def initialize(price:)
    @price = price
  end

  def +(number)
    @price += number
    self
  end
end

ticket = Ticket.new(price: 500)
ticket += 100
puts ticket.price # 600
