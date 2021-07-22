class Ticket
  MAX_COUNT = 300
  MAX_PRICE = 1_200

  class << self
    def max_count
      MAX_COUNT
    end

    def max_price
      MAX_PRICE
    end
  end
end


puts Ticket.max_count
puts Ticket.max_price
