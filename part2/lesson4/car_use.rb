require_relative 'car'

car = Car.new
car.build

puts car.title
puts car.description
puts car.engine.cylinders
puts car.engine.volume
puts car.engine.power
