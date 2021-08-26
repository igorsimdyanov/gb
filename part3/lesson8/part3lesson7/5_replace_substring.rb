# frozen_string_literal: true

def entries(path)
  Dir.new(path)
     .entries
     .reject { |x| %w[. ..].include? x }
     .map { |x| File.join(path, x) }
end

def scan_replace(path)
  entries(path).each do |item|
    if File.directory?(item)
      scan_replace(item)
    else
      File.write(item, File.read(item).gsub('ONE', 'ANOTHER'))
    end
  end
end

path = File.join('.')
scan_replace(path)
