# frozen_string_literal: true

result_hash = %i[first second third].each_with_index.map { |key, i| [key, i + 1] }.to_h
puts result_hash
