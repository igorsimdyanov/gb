# frozen_string_literal: true

p(1...10).group_by { |i| (i - 1) / 3 }
