# 5! = 1 * 2 * 3 * 4 * 5 = 120
# 1! = 1
# 0! = 1
def factorial(number)
  return 1 if number <= 1
  number * factorial(number - 1)
end

puts factorial(5)
