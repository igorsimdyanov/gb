class Ticket
  attr_accessor :price, :date
 
  def initialize(price, date)
    @price = price
    @date = date
  end

  def to_s
    "цена #{price}, дата #{date}"
  end

  def to_a
    [price, date]
  end

  def [](key)
    send(key) if respond_to? key
  end

  def []=(key, value)
    method = "#{key}=".to_sym
    send(method, value) if respond_to? method
  end

  alias to_ary to_a
  alias to_str to_s
end

ticket = Ticket.new(500, Time.mktime(2021, 7, 29, 10, 20))
p ticket.to_a
p [3, 5] + ticket
p ticket[:price]
ticket[:price] = 600
p ticket
