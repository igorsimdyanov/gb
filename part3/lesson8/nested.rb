Nested = Struct.new(:value)

n = Nested.new(Nested.new(Nested.new(:hello)))

p n.value.value.value
p n['value']['value']['value']
p n.dig('hello', 'world')
