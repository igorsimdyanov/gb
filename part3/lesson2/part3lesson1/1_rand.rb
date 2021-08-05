lines = File.readlines(ARGV.first).map(&:chomp)
puts lines[rand(lines.size - 1)] # puts lines.sample (не самый лучший вариант)
