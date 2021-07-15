class Ticket
  attr_accessor :date, :price
  
  def initialize(date:, price: 500)
    @price = price
    @date = date
  end
end

ticket = Ticket.new(
           date: Time.new(2021, 7, 16, 10, 20),
           price: 500
         )

#ticket.set_price(600)
ticket.price = 600
ticket.date = Time.new(2021, 7, 18, 10, 20)

puts "Цена билета: #{ticket.price}"
puts "Билет на дату: #{ticket.date}"
