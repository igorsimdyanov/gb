class Ticket
  def event
    'Иван Васильевич меняет профессию'
  end

  def price
    500
  end

  def room
    :white 
  end

  def used?
    false
  end
end

ticket = Ticket.new
p ticket.event
p ticket.price
p ticket.room
p ticket.used?
