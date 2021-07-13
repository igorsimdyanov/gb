# class Ticket
# end

# Ticket = Class.new do
#   def price
#     1_200
#   end  
# end

# ticket = Ticket.new
# p ticket.price

ticket = Class.new do
  def price
    1_200
  end  
end

t = ticket.new
p t.price
