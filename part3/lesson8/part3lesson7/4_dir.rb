# frozen_string_literal: true

def entries(path)
  Dir.new(path)
     .entries
     .reject { |x| %w[. ..].include? x }
     .select { |x| File.directory? "#{path}/#{x}" }
     .map { |x| File.join(path, x) }
end

def scan(path)
  entries(path).map do |item|
    item
  end
end

path = File.join('../')
entries(path).each do |item|
  print item
  subdirs = scan(item)
  print " (#{scan(item).join(', ')})" if subdirs.count.positive?
  puts
end
