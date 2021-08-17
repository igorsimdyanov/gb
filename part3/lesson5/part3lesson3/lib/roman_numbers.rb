# frozen_string_literal: true

# Convert Decimal numbers to Runans
module RomanNumbers
  ONES = %w[I X C M].freeze
  FIVES = %w[V L D].freeze
  LAMBDAS = {
    1 => ->(index) { first(index) },
    2 => ->(index) { second(index) },
    3 => ->(index) { third(index) },
    4 => ->(index) { fourth(index) },
    5 => ->(index) { fifth(index) },
    6 => ->(index) { sixth(index) },
    7 => ->(index) { seventh(index) },
    8 => ->(index) { eighth(index) },
    9 => ->(index) { nineth(index) }
  }.freeze

  def dec_to_roman(number)
    raise 'number must be in range from 1 to 2000' unless (1..2000).include? number

    result = ''
    index = 0
    loop do
      result = position(number, index, result)
      number /= 10
      index += 1
      break unless number.positive?
    end
    result
  end

  def position(number, index, pevious)
    LAMBDAS[number % 10].call(index) + pevious
  end

  def first(index)
    ONES[index]
  end

  def second(index)
    ONES[index] * 2
  end

  def third(index)
    ONES[index] * 3
  end

  def fourth(index)
    ONES[index] + FIVES[index]
  end

  def fifth(index)
    FIVES[index]
  end

  def sixth(index)
    FIVES[index] + ONES[index]
  end

  def seventh(index)
    FIVES[index] + ONES[index] * 2
  end

  def eighth(index)
    FIVES[index] + ONES[index] * 3
  end

  def nineth(index)
    ONES[index] + ONES[index + 1]
  end

  module_function :dec_to_roman, :position, :first,
                  :second, :third, :fourth, :fifth,
                  :sixth, :seventh, :eighth, :nineth
end
