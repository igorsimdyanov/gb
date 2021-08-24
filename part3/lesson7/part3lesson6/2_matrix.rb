# frozen_string_literal: true

MATRIX = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
].freeze

def trace(matrix)
  matrix.each_with_index.reduce(0) { |sum, (el, i)| sum + el[i] }
end

puts trace(MATRIX)
