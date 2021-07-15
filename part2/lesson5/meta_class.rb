class Ticket
  attr_accessor :price

  def initialize(price: 500)
    @price = price
  end
end

first = Ticket.new
second = Ticket.new(price: 600)

class << second
  def win
    'Ваш билет выграл'
  end
  # ...
end

puts "first.price = #{first.price}"
puts first.win if first.respond_to? :win
puts "second.price = #{second.price}"
puts second.win if second.respond_to? :win
