class Shop
  def method_missing(m, *args)
    puts 'Название метода'
    puts m
    puts 'Аргументы'
    p args
  end
end

shop = Shop.new
shop.buy_apple(42, 'set', 'get')
