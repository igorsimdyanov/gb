# frozen_string_literal: true

require_relative 'lib/roman_numbers'

class Integer
  include RomanNumbers
end

puts 888.roman
puts 199.roman
puts 14.roman
