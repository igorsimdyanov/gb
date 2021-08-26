require 'set'

# p Set.ancestors
# week = Set.new %w[monday thuesday wednesday thursday friday saturday sunday]
# weekend = Set['saturday', 'sunday']

# workday = Set.new

# workday << 'monday'
# workday << 'thuesday'
# workday << 'wednesday'
# workday << 'thursday'
# workday << 'friday'

# p workday

# workday << 'monday'

# p workday

# workday.delete 'monday'

# p workday

workday = Set.new %w[monday thuesday wednesday thursday friday]
weekend = Set['saturday', 'sunday']
week = workday + weekend


week = Set.new %w[monday thuesday wednesday thursday friday saturday sunday]
p week - weekend