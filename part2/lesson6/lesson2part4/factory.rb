# frozen_string_literal: true

require 'ostruct'

# Фабрика
class Factory
  GOODS = %i[teddy_bear ball cube].freeze
  GOODS_ERROR = 'Введен недопустимый цвет, разрешено %s'
  @counter = 0

  class << self
    def build(good)
      raise format(GOODS_ERROR, GOODS.join(' ')) unless GOODS.include?(good)

      @counter += 1
      const_get(classify(good)).new(good)
    end

    def classify(str)
      str.to_s.split('_').collect(&:capitalize).join
    end

    def total
      @counter
    end
  end

  GOODS.each do |name|
    # teddy_bear => TeddyBear
    const_set(Factory.classify(name), Struct.new(:name))
  end
end

fst = Factory.build(:ball)
p fst
snd = Factory.build(:teddy_bear)
p snd
thd = Factory.build(:cube)
p thd

# fth = Factory.build(:cude)
# p fth

puts Factory.total
