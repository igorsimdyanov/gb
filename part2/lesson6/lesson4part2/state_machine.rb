# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

# class Substance
# Олег Сергеев
class Substance
  attr_accessor :state

  StateMachines::Machine.ignore_method_conflicts = true

  STATES_RAND = { solid: 1, gas: 2, liquid: 3 }.freeze
  ACTS_RAND = { freeze: 1, boil: 2, condense: 3, sublime: 4, deposit: 5 }.freeze

  state_machine :state, initial: -> { STATES_RAND.key(rand(1..3)) } do
    event :melt do
      transition from: :solid, to: :liquid
    end
    event :freeze do
      transition from: :liquid, to: :solid
    end
    event :boil do
      transition from: :liquid, to: :gas
    end
    event :condense do
      transition from: :gas, to: :liquid
    end
    event :sublime do
      transition from: :solid, to: :gas
    end
    event :deposit do
      transition from: :gas, to: :solid
    end
  end
end

substance = Substance.new
action = Substance::ACTS_RAND.key(rand(1..5))
puts action
puts substance.state
