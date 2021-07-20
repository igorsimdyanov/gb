class Ticket
  attr_accessor :price
 
  def initialize(price)
    @price = price
  end

  def +(value)
    case value
    when Ticket
      price + value.price
    when Numeric
      @price += value
      self
    end
  end

  def to_s
    price.to_s
  end
  alias to_str to_s
end
