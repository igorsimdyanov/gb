# first = {}
# second = { 'first' => 1, 'second' => 2 }
# third = { first: 1, second: 2 }
# p first
# p second
# p third

p Hash.new # {}

p Hash[:first, 1, :second, 2]
p [[:first, 1], [:second, 2]].to_h
