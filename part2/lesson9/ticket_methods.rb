class Ticket
  attr_accessor :date, :price
  @@next_number = 1

  def initialize(date:, price: 500)
    @date = date
    @price = price
    @number = @@next_number
    @@next_number += 1
  end

  def price
    price_format(@price)
  end

  def <=>(ticket)
    number <=> ticket.number
  end

  private

  def price_format(price)
    format('Цена билета %d', price)
  end

  protected

  def number
    @number
  end
end

# fst = Ticket.new(date: Time.mktime(2021, 7, 30, 10, 20))
# snd = Ticket.new(date: Time.mktime(2021, 7, 30, 10, 20))

# # puts fst <=> snd # -1

# p fst.public_methods(false)
# p fst.private_methods(false)
# p fst.protected_methods(false)

# p Ticket.public_instance_methods(false)
# p Ticket.private_instance_methods(false)
# p Ticket.protected_instance_methods(false)
