# frozen_string_literal: true

require 'ostruct'
require_relative 'lib/coords'

submarines = 3.times.map do
  x, y = Coords.generate
  OpenStruct.new missles: rand(10), torpedos: rand(10), x: x, y: y
end

p submarines

cruisers = 3.times.map do
  x, y = Coords.generate
  OpenStruct.new missles: rand(10), x: x, y: y
end

p cruisers

transports = 3.times.map do
  x, y = Coords.generate
  OpenStruct.new hold: true, crane: true, x: x, y: y
end

p transports
