module Hello
  def say(name)
    "Hello, #{name}!"
  end
end

# ticket = Object.new

# ticket.extend Hello

# puts ticket.say('Ruby')

# extend Hello

# puts say('Ruby')

class Greet
  extend Hello
  # def self.say(name)
  #   "Hello, #{name}!"
  # end
  # class << self
end

puts Greet.say('Ruby')
