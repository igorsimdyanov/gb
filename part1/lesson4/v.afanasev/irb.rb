# frozen_string_literal: true

# Умножить 2 числа в интерактивном Ruby (irb)
class H
  def [](a, b)
    puts a * b
  end
end

obj = H.new

obj[87_220, 356_782]

# rubocop:disable Lint/Debugger
binding.irb
# rubocop:enable Lint/Debugger
