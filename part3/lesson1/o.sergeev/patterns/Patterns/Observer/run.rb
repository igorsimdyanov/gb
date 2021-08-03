# frozen_string_literal: true

require_relative 'lib/traficlight'

STREETS = %i[Studenaya Moskovskaya].freeze
traffic_light1 = TwoWayTrafficLight.new(STREETS)

bus = Bus.new(STREETS.first)
traffic_light1.drive_up(bus)

truck = Truck.new(STREETS.last)
traffic_light1.drive_up(truck)

traffic_light1.start_light

traffic_light1.drive_off(bus)
traffic_light1.drive_off(truck)

