# frozen_string_literal: true

require_relative 'lib/group'

group = Group.new

group << Group::User.new(
  name: 'Иван Петров',
  email: 'i.petrov@example.com'
)

group << Group::User.new(
  name: 'Петр Иванов',
  email: 'p.ivanov@example.com'
)

group << Group::User.new(
  name: 'Сергей Сидров',
  email: 's.sidorov@example.com'
)

list = group.map { |u| "#{u.name} (#{u.email})" }
puts list
