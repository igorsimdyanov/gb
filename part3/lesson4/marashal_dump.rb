require_relative 'ticket'

ticket = Ticket.new(600)
str = Marshal.dump(ticket)

t = Marshal.load(str)

p ticket       #<Ticket:0x00007f7fd809f808 @price=600>
p t            #<Ticket:0x00007f7fd809f628 @price=600>
p t.price      # 600
