class Rainbow
  COLORS = {
    red: 'красный',
    orange: 'оранжевый',
    yellow: 'желтый'
  }

  def method_missing(name)
    COLORS[name]
  end
end


r = Rainbow.new
puts r.yellow
puts r.red