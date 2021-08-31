class RandException < Exception; end

class Ticket
  attr_accessor :price, :date

  def initialize(date:, price: 500)
    raise RandException.new('Ошибка создания билета') if rand(2).zero?
    @price = price
    @date = date
  end
end

begin
  10.times.map do |i|
    p Ticket.new(date: Time.new)
  end
rescue RandException => e
  puts "Возника ошибка #{e.class}: #{e.message}"
rescue RuntimeError => e
  puts "Возника ошибка #{e.class}: #{e.message}"
end