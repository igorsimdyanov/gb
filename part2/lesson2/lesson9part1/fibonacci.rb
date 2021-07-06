# frozen_string_literal: true

def fibonacci(number)
  return number if (0..1).include? number

  (fibonacci(number - 1) + fibonacci(number - 2))
end

def bine(number)
  f = ((1 + Math.sqrt(5)) / 2)**number
  s = ((1 - Math.sqrt(5)) / 2)**number
  ((f - s) / Math.sqrt(5)).round
end

puts fibonacci(10)
puts fibonacci(30)

puts bine(10)
puts bine(30)
