# frozen_string_literal: true

require 'time'

# Расширяем класс Time
# Олег Сергеев
class Time
  MORNING = (Time.parse('06:00:00')..Time.parse('11:59:59'))
  DAY = (Time.parse('12:00:00')..Time.parse('17:59:59'))
  EVENING = (Time.parse('18:00:00')..Time.parse('23:59:59'))
  NIGHT = (Time.parse('00:00:00')..Time.parse('05:59:59'))

  GREETING = {
    MORNING => 'Доброе утро!',
    DAY => 'Добрый день!',
    EVENING => 'Добрый вечер!',
    NIGHT => 'Добрый ночи!'
  }.freeze

  def hello
    GREETING.find { |range, _phrase| range.cover?(Time.now) }.last
  end
end

time = Time.new
puts time.hello
