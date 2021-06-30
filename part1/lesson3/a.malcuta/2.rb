class Computer
  def name
    puts 'First'
  end
end
comp = Computer.new
puts comp.name

class Web
  def name
    puts 'World_web'
  end
end
web = Web.new
puts web.name

class Host
  def name
    puts '192.145.6.6'
  end
end
host = Host.new
puts host.name

class User
  def name
    puts 'User_1'
  end

  def fio
    puts 'Введите вашу фамилию'
    last_name = gets.chomp
    puts 'Введите ваше имя'
    first_name = gets.chomp
    fio = last_name +' и '+ first_name
    puts "Ваши фамилия, имя - #{fio} \n"
  end

  def profession
    puts 'Введите вашу профессию'
    prof = gets.chomp
    puts "Ваша - профессия - #{prof} \n"
  end

end

user = User.new
puts user.name
user.fio
user.profession
