# frozen_string_literal: true

# Class checks the denominator
class Input
  def denominator
    num = 0
    loop do
      puts 'Введите знаменатель больше нуля: '
      num = gets.to_f
      break unless num <= 0
    end
    num
  end

  def denomin
    puts 'Введите знаменатель больше нуля: '
    num = gets.to_f
    num.positive? ? num : denomin
  end
end
