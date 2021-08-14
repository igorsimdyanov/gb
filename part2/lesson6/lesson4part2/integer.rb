# frozen_string_literal: true

# Расширяем класс Integer
# Олег Сергеев
class Integer
  MSEC = 60
  HSEC = 3_600
  DSEC = 86_400

  def minutes
    self * MSEC
  end

  def hours
    self * HSEC
  end

  def days
    self * DSEC
  end
end

puts "#{5.minutes} сек."
puts "#{5.hours} сек."
puts "#{5.days} сек."
