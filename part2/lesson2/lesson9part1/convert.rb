# frozen_string_literal: true

def convert(*values)
  values.map { |val| val * 1000 }
end

p convert(4, 24, 332, 32, 2)
