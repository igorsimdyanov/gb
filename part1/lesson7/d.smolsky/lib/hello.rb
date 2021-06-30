# frozen_string_literal: true

require 'date'

class Hello
  MORNING = (DateTime.parse('06:00')...DateTime.parse('12:00')).freeze
  DAY = (DateTime.parse('12:00')...DateTime.parse('18:00')).freeze
  EVENING = (DateTime.parse('18:00')...DateTime.parse('23:59')).freeze
  NIGHT = (DateTime.parse('23:59')...DateTime.parse('06:00')).freeze

  def hello
    return 'Доброе утро' if MORNING.cover?(DateTime.now)
    return 'Добрый день' if DAY.cover?(DateTime.now)
    return 'Добрый вечер' if EVENING.cover?(DateTime.now)
    return 'Добрый ночи' if NIGHT.cover?(DateTime.now)
  end
end
