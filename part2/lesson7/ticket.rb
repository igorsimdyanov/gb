# frozen_string_literal: true

# Ticket class
class Ticket
  attr_accessor :price, :date

  def initialize(date:, price: 500)
    # self.price = price
    # self.date = date
    @price = price
    @date = date
  end

  def to_s
    "цена: #{price}"
  end
end

# p Ticket.instance_methods(false)
ticket = Ticket.new(date: Time.now, price: 600)

p ticket.price
p ticket.date
