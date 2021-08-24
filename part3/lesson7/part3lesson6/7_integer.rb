# frozen_string_literal: true

# Open Integer class
class Integer
  def to_a(digit = 2)
    digit = 2 unless [2, 8, 16].include? digit
    to_s(digit).split ''
  end
end

p 10.to_a(8)
p 10.to_a(16)
