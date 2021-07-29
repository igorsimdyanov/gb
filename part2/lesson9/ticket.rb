class Ticket
  def initialize(date:, price: 500)
    @price = price
    @date = date
  end

  public

  def date
    @date
  end

  def price
    @price
  end

  # public :price, :date
end

ticket = Ticket.new date: Time.mktime(2021, 7, 29, 10, 10)
puts ticket.date
puts ticket.price
