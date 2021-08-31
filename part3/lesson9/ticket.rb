class Ticket
  attr_accessor :price, :date

  def initialize(date:, price: 500)
    raise 'Ошибка создания билета' if rand(2).zero?
    @price = price
    @date = date
  end
end
