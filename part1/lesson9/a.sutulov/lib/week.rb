# frozen_string_literal: true

# Класс дней недали
class Week
  WEEK = %w[Понедельник Вторник Среда Четверг Пятница Суббота Воскресенье].freeze
 
  def find_right(num)
    WEEK[num - 1] if (1..WEEK.size).include?(num)
  end
end
