# h = Hash.new(Object.new)

# p h
# p h[:hello]
# p h[:world]
# p h[:params]

# h = Hash.new({})

# p h[:params][:per_page] = 30
# p h[:params]
# p h[:settings]

h = Hash.new { |h, k| h[k] = {} }

# h[:params] ||= {}
# h[:params][:per_page] = 30

p h[:params][:per_page] = 30
p h[:params]
p h[:settings]
