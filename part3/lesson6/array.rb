p [1, 2, 3, 4, 5]  # [1, 2, 3, 4, 5]
p [*1..5]          # [1, 2, 3, 4, 5]
p (1..5).to_a      # [1, 2, 3, 4, 5]
p Array.new(5, 1)  # [1, 1, 1, 1, 1]
p Array.new(5) { |i| i + 1 } # [1, 2, 3, 4, 5]
p %w[1 2 3 4 5]    # ["1", "2", "3", "4", "5"]
p %i[1 2 3 4 5]    # [:"1", :"2", :"3", :"4", :"5"]
