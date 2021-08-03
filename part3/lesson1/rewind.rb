count = 0

File.open('rewind.rb', 'r') do |file|
  file.each { count += 1 }

  puts "Строк в файле: #{count}"

  file.rewind
  file.each_with_index { |line, i| puts "#{i + 1} #{line}" }
end
