positions = Array.new(4)

File.open(ARGV.first, 'r') do |file|
  file.each do |line|
    positions.pop
    positions.unshift file.pos
  end

  file.seek positions.last

  file.each { |line| puts line }
end
