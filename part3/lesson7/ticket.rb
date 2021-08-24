class Ticket
  attr_accessor :price

  def initialize(price)
    @price = price
  end

  def ==(ticket)
    price == ticket.price
  end

  def hash
    price.hash
  end

  def eql?(ticket)
    price == ticket.price
  end
end

fst = Ticket.new(500)
snd = Ticket.new(500)

# p fst.equal?(snd)
p fst.eql?(snd)
