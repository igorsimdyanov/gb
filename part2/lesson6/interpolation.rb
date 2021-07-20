# frozen_string_literal: true

require_relative 'ticket'

t = Ticket.new(500)

puts "Цена билета #{t} рублей" # to_s
puts "Цена билета #{t} рублей" # to_str
