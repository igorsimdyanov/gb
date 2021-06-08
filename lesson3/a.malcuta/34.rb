class User_for_file
  def name
    name = 'User_1'
    return name
  end

  def fio
    puts 'Введите вашу фамилию'
    user_f = gets.chomp
    puts 'Введите ваше имя'
    user_n = gets.chomp
    f_n = user_f +' и '+ user_n
    return f_n
  end

  def profession
    puts 'Введите вашу профессию'
    user_prof = gets.chomp
    return user_prof
  end
end

p 'Начинаем работу с файлом'
user = User_for_file.new
File.write('user.txt', [user.fio, user.profession].join(','))
