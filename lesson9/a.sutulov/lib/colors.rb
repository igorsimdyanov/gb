# frozen_string_literal: true

# Класс цвета радуги
# Rubocop ругается, но хотелось попробывать в деле case
# rubocop:disable Metrics/CyclomaticComplexity
class Colors
  def find_right(num)
    case num
    when 1 then 'красный'
    when 2 then 'оранжевый'
    when 3 then 'жёлтый'
    when 4 then 'зелёный'
    when 5 then 'голубой'
    when 6 then 'синий'
    when 7 then 'фиолетовый'
    end
  end
end
# rubocop:enable Metrics/CyclomaticComplexity
