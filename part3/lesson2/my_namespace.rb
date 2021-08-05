module MyNamespace
  class Array
    def to_s
      'my class'
    end
  end
end

p Array.new                 # []
p MyNamespace::Array.new    # #<MyNamespace::Array:0x00007fc9378d1c80>

puts Array.new              #
puts MyNamespace::Array.new # my class
