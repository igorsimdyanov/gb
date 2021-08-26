require 'set'
week = Set.new %w[monday thuesday wednesday thursday friday saturday sunday]
weekend = Set.new %w[saturday sunday]

p week & weekend

week_arr = %w[monday thuesday wednesday thursday friday saturday sunday]
weekend_arr = %w[saturday sunday]

p week_arr & weekend_arr
