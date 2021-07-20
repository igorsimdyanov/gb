class HelloWorld
  def +@
    puts 'Перегрузка оператора +hello'
  end

  def -@
    puts 'Перегрузка оператора -hello'
  end

  def !@
    puts 'Перегрузка оператора !hello'
  end
end

hello = HelloWorld.new

+hello
-hello
!hello

# <=/=>