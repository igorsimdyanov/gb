class Shop
  define_method :cube do |arg|
    arg ** 3
  end
end

shop = Shop.new
puts shop.cube(2)
