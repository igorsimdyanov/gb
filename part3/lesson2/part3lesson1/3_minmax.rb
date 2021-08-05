lines = File.readlines(ARGV.first).map(&:chomp)
min, max = lines.minmax_by(&:size)
puts "Минимальное слово: #{min} (#{min.size})"
puts "Максимальное слово: #{max} (#{max.size})"
