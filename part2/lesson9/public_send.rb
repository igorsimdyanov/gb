puts Object.public_send(:object_id)

CONST = 1
puts CONST
Object.public_send(:remove_const, :CONST)
CONST = 2
puts CONST

