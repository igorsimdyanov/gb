require 'forwardable'

class Ticket
  include Comparable
  extend Forwardable
  attr_accessor :price
  def_delegator :@price, :<=>, :<=>

  def initialize(price)
    @price = price
  end
end

first = Ticket.new(500)
second = Ticket.new(600)

if first > second.price
  puts 'Первый билет стоит дороже'
elsif first < second.price
  puts 'Второй билет стоит дороже'
else
  puts 'Билеты стоят одинаково'
end
