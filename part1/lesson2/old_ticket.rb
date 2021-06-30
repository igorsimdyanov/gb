class Ticket
  def price
    puts 3500
  end
end

ticket = Ticket.new
second = Ticket.new
third = Ticket.new

puts ticket.class
puts second.class
puts third.class

puts ticket.price

# puts ticket + second
