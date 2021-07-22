class Ticket
  attr_accessor :date, :price

  def initialize
    yield self
  end
end

ticket = Ticket.new do |t|
  t.price = 600
  t.date = Time.mktime(2021, 7, 25, 10, 20)
end

p ticket.price
p ticket.date
