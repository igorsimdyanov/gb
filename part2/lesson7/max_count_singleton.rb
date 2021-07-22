class Ticket
  MAX_COUNT = 300
  MAX_PRICE = 1_200

  # self == Ticket
  def self.max_count
    MAX_COUNT
  end

  def self.max_price
    MAX_PRICE
  end
end

puts Ticket.max_count
puts Ticket.max_price
