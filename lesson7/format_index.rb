puts format('%d + %d = %d', 2, 2, 2 + 2) # 2 + 2 = 4
puts format('%1$d + %1$d = %2$d', 2, 2 + 2)

puts format(
  '%<operand>d + %<operand>d = %<result>d',
  operand: 2,
  result: 2 + 2
)