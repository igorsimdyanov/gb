class Hello
  def greeting
    'Hello, world!'
  end
end

h = Hello.new
o = Object.new

puts h.greeting

binding.irb

puts o.greeting
