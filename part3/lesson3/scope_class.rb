module Scope
  class << self
    public

    def say(name)
      "Scope#say: Hello, #{name}!"
    end

    def get_greeting(name)
      self.greeting(name)
    end

    def get_hello(name)
      hello(name)
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
end

puts Scope.say('Ruby')
puts Scope.get_greeting('Ruby')
puts Scope.get_hello('Ruby')
