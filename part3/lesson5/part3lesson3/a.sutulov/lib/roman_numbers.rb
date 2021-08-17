# Module convert arabic to roman numbers
module RomanNumbers
  ROM = %w[M CM D CD C XC L XL X IX V IV I].freeze
  ARB = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1].freeze

  def roman
    arb = self
    ARB.each_with_index.each_with_object('') do |(num, i), result|
      while arb >= num
        arb -= num
        result << ROM[i]
      end
    end
  end
end
