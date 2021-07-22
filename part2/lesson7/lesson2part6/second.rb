# frozen_string_literal: true

result_hash = %w[first second third]
              .each_with_index
              .map { |el, i| [el, "#{el[0].upcase + el[-2..]} (#{i + 1})"] }
              .to_h
puts result_hash
