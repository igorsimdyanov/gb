Point = Struct.new(:x, :y)
point = Point.new(3, 4)
# point.each { |x| puts x }
point.each_pair { |k, v| puts "#{k} => #{v}" }
