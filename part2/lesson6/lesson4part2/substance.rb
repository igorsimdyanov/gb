# frozen_string_literal: true

# Олег Сергеев
class Substance
  attr_accessor :state

  STATES = { solid: %i[deposit freeze], gaz: %i[boil sublime], liquid: %i[condense melt] }.freeze
  RU = { 'твердое' => :solid, 'газообразное' => :gaz, 'жидкое' => :liquid }.freeze
  STATES_RAND = { solid: 1, gaz: 2, liquid: 3 }.freeze
  def initialize
    @state = STATES_RAND.key(rand(1..3))
  end

  def freeze
    status(:freeze)
  end

  def boil
    status(:boil)
  end

  def condense
    status(:condense)
  end

  def sublime
    status(:sublime)
  end

  def deposit
    status(:deposit)
  end

  def melt
    status(:melt)
  end

  def status(act)
    STATES.each do |sym, arr|
      arr.each do |value|
        return check_state(sym) if value == act
      end
    end
  end

  def check_state(act_state)
    if act_state == state
      "Переход вещества в состояние '#{RU.key(act_state)}' невозможен, т.к. начальное состояние'#{RU.key(state)}'"
    else
      "Переход вещества в состояние '#{RU.key(act_state)}', начальное '#{RU.key(state)}'"
    end
  end
end

water = Substance.new
puts water.freeze
ice = Substance.new
puts ice.melt
