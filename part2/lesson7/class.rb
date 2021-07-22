class Ticket
  puts self # Ticket
  class Summary
    puts self # Ticket::Summary
  end
  puts self # Ticket
end
