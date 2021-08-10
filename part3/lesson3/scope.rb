module Scope
  public

  def say(name)
    "Scope#say: Hello, #{name}!"
  end

  protected

  def greeting(name)
    "Scope#greeting: Hello, #{name}!"
  end

  private

  def hello(name)
    "Scope#hello: Hello, #{name}!"
  end
end

# class HelloWorld
#   include Scope # mix
# end

# h = HelloWorld.new

# puts h.say('Ruby')
# # puts h.greeting('Ruby')puts
# puts h.hello('Ruby')

class HelloWorld
  extend Scope # mix
end

puts HelloWorld.say('Ruby')
# puts HelloWorld.greeting('Ruby')
# puts HelloWorld.hello('Ruby')
