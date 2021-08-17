arr = [1, 2, 3, 4, 5]

arr.freeze

arr.delete_at(0)
p arr

def arr.say(name)
  "Hello, #{name}!"
end

puts arr.say 'Ruby'
