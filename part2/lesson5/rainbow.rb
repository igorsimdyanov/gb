class Rainbow
  COLORS = {
    red: 'красный',
    orange: 'оранжевый',
    yellow: 'желтый'
  }

  COLORS.each do |method, name|
    define_method method do
      name
    end
  end
end


r = Rainbow.new
puts r.yellow
puts r.red
