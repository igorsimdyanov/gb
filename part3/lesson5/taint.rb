hello = ARGV.first
p hello.tainted?
hello.taint
p hello.tainted?
hello.untaint
p hello.tainted?
