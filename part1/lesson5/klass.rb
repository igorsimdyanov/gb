class User
  @@counter = 0

  def counter
    @@counter
  end

  def set_counter(counter)
    @@counter = counter
  end
end

first = User.new
first.set_counter 10

second = User.new
puts second.counter # 10
