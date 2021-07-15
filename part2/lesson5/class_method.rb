class HelloWorld
  def self.klass
    'Метод класса'
  end

  def instance
    'Метод объекта'
  end
end

puts HelloWorld.klass
puts HelloWorld.new.instance
# puts HelloWorld::greeting