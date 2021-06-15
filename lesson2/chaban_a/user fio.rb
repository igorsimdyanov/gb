class User
	def fio
		'Чабан Артур'
	end

	def profession
		'Менеджер'
	end
end

user = User.new
p user.fio # Тут ФИО специально не добовлял.
p 'Профессия: ' + user.profession
