class Hello
  def say(name)
    "Hello, #{name}!"
  end
end

class Greet
  # include Hello
end

obj = Greet.new
obj.extend Hello
