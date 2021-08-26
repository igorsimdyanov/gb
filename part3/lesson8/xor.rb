require 'set'

workday = Set.new %w[monday thuesday wednesday thursday friday]
week = Set.new %w[thursday friday saturday sunday]

p workday ^ week
