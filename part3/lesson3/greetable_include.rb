module Greetable
  def say(name)
    "Greetable#say: Hello, #{name}"
  end
end

class Greet
  include Greetable # prepend
  def say(name)
    "Greet#say: Hello, #{name}"
  end
end

class Hello < Greet
  def say(name)
    "Hello#say: Hello, #{name}"
  end
end

# hello = Hello.new
# puts hello.say('Ruby') # Hello#say: Hello, Ruby
