# h = { first: 1, second: 2, third: 3}

# p h.slice(:first)
# p h.slice(:first, :third)
# h.clear

# h = { first: 1, second: 2, third: 3}

# p h
# p h.delete(:first)
# p h
# p h.delete(:third)
# p h

h = { first: 1, second: 2, third: nil}

p h.compact!
p h