str = 'ИВАНОВ ИВАН'
# puts "#{str[1]}#{str[0]}#{str[3]}#{str[4]}" # ВИНО
# puts str[7, 9]
# puts str[7..9]
# puts str[7..-2]

puts str.sub('ИВАН', 'ПЕТР')
puts str.gsub('ИВАН', 'ПЕТР')
puts str.length
puts str.size
