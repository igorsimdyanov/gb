class Ticket
	def date 
		'15.06.2021'
	end

	def price
		3500
	end

	def row
		4
	end

	def seat
		'12'

	def event
		'Трудно быть Рубистом'
	end
end

ticket = Ticket.new
p "Дата сеанса: " + ticket.date
p "Стоимость: " + ticket.price.to_s
p "Ряд №: " + ticket.row.to_s
p "Место №: " + ticket.seat
p "Фильм: " + ticket.event
