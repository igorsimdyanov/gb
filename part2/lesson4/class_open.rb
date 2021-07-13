class Ticket
  def event
    'Событие 1'
  end
end

class Ticket
  def event
    'Событие 2'
  end
end

ticket = Ticket.new
puts ticket.event
