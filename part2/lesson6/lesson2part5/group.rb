# frozen_string_literal: true

require_relative 'user'

# Класс группы студентов
class Group
  attr_accessor :list

  def initialize(list)
    @list = list
  end

  def each(&block)
    list.each(&block)
  end
end

users = [
  User.new(
    first_name: 'Игорь',
    last_name: 'Симдянов',
    middle_name: 'Вячеславович'
  ),
  User.new(
    first_name: 'Игорь1',
    last_name: 'Симдянов1',
    middle_name: 'Вячеславович1'
  ),
  User.new(
    first_name: 'Игорь2',
    last_name: 'Симдянов2',
    middle_name: 'Вячеславович2'
  )
]

grp = Group.new(users)
grp.each { |user| puts user }
