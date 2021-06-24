# frozen_string_literal: true

print 'Введите число:'
n = gets.to_i
if (n & 1).zero?
  puts 'Число четное'
else
  puts 'Число не четное'
end

=begin
1010101010101
&
0000000000001
=
0000000000001 # 1

1010101010100
&
0000000000001
=
0000000000000 # 0
=end
