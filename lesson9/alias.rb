def convert(value:, factor: 1000)
  value * factor
end

alias kg_to_grams convert
alias kb_to_bytes convert

puts kg_to_grams(value: 5)
puts kb_to_bytes(value: 11, factor: 1024)
