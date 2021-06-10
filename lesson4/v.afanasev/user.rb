# frozen_string_literal: true

##
# Класс пользователя
class User
  ##
  # Указываем методы ФИО
  def surname
    'Фамилия'
  end

  def name
    'Имя'
  end

  def patronymic
    'Отчество'
  end

  def profession
    'Профессия'
  end
end

##
# Создаем новый обьект пользователя
user = User.new

##
# Выводим ФИО
puts user.surname
puts user.name
puts user.patronymic
puts user.profession
