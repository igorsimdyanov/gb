# frozen_string_literal: true

# Абстрактный класс пользователя
class Person
  CREATE_ERROR = 'Нельзя создавать объект абстрактного класса'
  attr_accessor :first_name, :last_name, :middle_name, :email

  def initialize(first_name:, last_name:, middle_name:, email:)
    @first_name = first_name
    @last_name = last_name
    @middle_name = middle_name
    @email = email

    raise CREATE_ERROR if instance_of?(Person)
  end
end

# Обычный пользователь
class User < Person; end

# Администратор
class Admin < User; end

# Модератор
class Moderator < User; end

user = Moderator.new(
  first_name: 'Игорь',
  last_name: 'Симдянов',
  middle_name: 'Вячеславович',
  email: 'igorsimdyanov@gmail.com'
)

p user

user = Person.new(
  first_name: 'Игорь',
  last_name: 'Симдянов',
  middle_name: 'Вячеславович',
  email: 'igorsimdyanov@gmail.com'
)

p user
