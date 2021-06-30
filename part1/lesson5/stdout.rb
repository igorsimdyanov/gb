require 'stringio'

$stdout = StringIO.new
puts 'Hello, world!'
File.write('stdout.txt', $stdout.string)
