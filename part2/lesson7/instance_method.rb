class Ticket
  def price
    d = Ticket.date
    self       #<Ticket:0x00007fc07e081f38>
  end

  def self.date # Ticket.date
    Time.now
  end
end

ticket = Ticket.new
p ticket.price #<Ticket:0x00007fc07e081f38>
p ticket       #<Ticket:0x00007fc07e081f38>