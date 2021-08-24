# frozen_string_literal: true

number = ARGV.first.to_i.abs
result = 2.upto(number).each_with_object([1]) do |i, arr|
  arr.push(i)
  arr.unshift(i)
end

p result
