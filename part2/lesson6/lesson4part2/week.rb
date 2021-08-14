# frozen_string_literal: true

# Коллекция дней недели
class Week
  DAYS = %w[понедельник вторник среда четверг пятница суббота воскресенье].freeze

  def each(&block)
    DAYS.each(&block)
  end
end

week = Week.new
week.each { |day| puts day.capitalize }
