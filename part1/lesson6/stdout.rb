require 'stringio'

$stdout = StringIO.new

puts 'Hello, world!'
File.write('out.out', $stdout.string)

$stdout = STDOUT

puts 'Hello, ruby!'
