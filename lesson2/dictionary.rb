class Ticket
  def price
    puts 3500
  end
end

t = Ticket.new
o = Object.new
# t.price
# o.price

# puts t.class
# puts o.class

# puts t.respond_to? 'price'
# puts o.respond_to? 'price'

# puts 3500.methods
