# frozen_string_literal: true

# Open Integer class
class Integer
  def to_a
    to_s(2).split('').map(&:to_i)
  end
end

p 10.to_a
