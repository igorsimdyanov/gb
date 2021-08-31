# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require_relative 'game/field'

field = Field.new

Ship::MAX_DECKS.downto(Ship::MIN_DECKS) do |ship_size|
  Ships.how_many(ship_size).times do
    loop do
      ship = Ship.new(ship_size)
      next if field.out_of_field?(ship) || field.touch_another_ship?(ship)

      field.add_ship(ship)
      break
    end
  end
end

field.print_field
