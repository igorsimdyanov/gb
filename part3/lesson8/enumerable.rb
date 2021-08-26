require 'set'

week = Set.new %w[monday thuesday wednesday thursday friday saturday sunday]
p week.select { |d| d.start_with? 's' }.map(&:upcase)

p week.size