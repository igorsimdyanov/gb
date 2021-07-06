# frozen_string_literal: true

require_relative 'lib/user'

users = Array.new(3) do
  print 'Введите ФИО пользователя (например, Иванов Иван Иванович) '
  surname, name, patronymic = gets.chomp.split(/\s+/)
  User.new(surname, name, patronymic)
end

p users
