# frozen_string_literal: true

require_relative 'user'

user = User.new(
  first_name: 'Игорь',
  last_name: 'Симдянов',
  middle_name: 'Вячеславович'
)

puts user
