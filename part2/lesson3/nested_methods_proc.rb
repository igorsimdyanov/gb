def greeting(name, &block)
  block.call(name)
end

def outer(name, &block)
  greeting(name, &block)
end

outer('Ruby') { |name| puts "Hello, #{name}!" }
