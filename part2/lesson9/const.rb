CONST = 1
puts CONST
Object.send(:remove_const, :CONST)
CONST = 2
puts CONST
