# frozen_string_literal: true

# Обычный пользователь
class User
  attr_accessor :first_name, :last_name, :middle_name, :email

  def initialize(first_name:, last_name:, middle_name:, email:)
    @first_name = first_name
    @last_name = last_name
    @middle_name = middle_name
    @email = email
  end

  def say
    # self.class - User
    # self.class.name - 'User'
    self.class.name
  end

  alias to_s say
end

# Автор
class Author < User; end

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

puts user.say
puts user
