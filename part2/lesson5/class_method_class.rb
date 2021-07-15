class HelloWorld
  class << self
    def klass
      'Метод класса'
    end

    def another
      'Друго метод класса'
    end
  end

  def instance
    'Метод объекта'
  end
end

puts HelloWorld.klass
puts HelloWorld.new.instance
# puts HelloWorld::greeting