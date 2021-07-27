class First; end
class Second; end

class Child < rand(0..1).zero? ? First : Second
  class Fst; end
end

# Child::Fst

puts Child.superclass
