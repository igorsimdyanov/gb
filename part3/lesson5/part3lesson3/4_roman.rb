# frozen_string_literal: true

require_relative 'lib/roman_numbers'

# Extend Integer class
class Integer
  def roman
    RomanNumbers.dec_to_roman(self)
  end
end

puts 888.roman
puts 199.roman
puts 14.roman
