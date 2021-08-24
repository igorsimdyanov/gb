# frozen_string_literal: true

result = [1, 2, 3, 4, 5].each_with_object([]) do |val, arr|
  arr << val if val.odd?
end

p result
