# frozen_string_literal: true

# Класс здания
class Building
  attr_accessor :number_of_storey, :type

  def initialize(storey: 1, type: :wood)
    @number_of_storey = storey
    @type = type
  end
end

STOREY_FORMAT = 'Этажность: %d'
TYPE_FORMAT = 'Материал дома: %s'

fst = Building.new
puts format(STOREY_FORMAT, fst.number_of_storey)
puts format(TYPE_FORMAT, fst.type)

snd = Building.new(storey: 9, type: :brick)
puts format(STOREY_FORMAT, snd.number_of_storey)
puts format(TYPE_FORMAT, snd.type)
