# frozen_string_literal: true

# Open Array class
class Array
  def for(number = nil, &block)
    return if number.negative?
    i = 0
    loop do
      each(&block)
      i += 1
      break if number && i >= number
    end
  end
end

[1, 2, 3].for(-2) { |x| puts x }
