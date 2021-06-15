class Ticket
  def set_price(price)
    @price = price
  end

  def price
    @price
  end

  def set_date(date)
    @date = date
  end

  def date
    @date
  end
end

fst = Ticket.new
fst.set_price(3_500)
fst.set_date('20.06.2021')

snd = Ticket.new
snd.set_price(3_000)
snd.set_date('22.06.2021')

puts fst.price # 3 500
puts fst.date

puts snd.price # 3 000
puts snd.date

# Так не делаем - замаскированная глобальная переменная
# @count = 3
# puts @count
