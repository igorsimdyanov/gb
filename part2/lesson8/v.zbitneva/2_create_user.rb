# frozen_string_literal: true

require_relative 'lib/user'

user = User.new do |usr|
  usr.surname = 'Паркер'
  usr.name = 'Кай'
  usr.patronymic = 'Джошуа'
  usr.email = 'cobra.kai.1972@gmail.com'
end

puts "Имя: #{user.name}"
puts "Отчество: #{user.patronymic}"
puts "Фамилия: #{user.surname}"
puts "Е-мейл: #{user.email}"
