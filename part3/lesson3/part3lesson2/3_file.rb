# frozen_string_literal: true

require_relative 'lib/integer'

size = File.size(ARGV.first)
puts size.human_size
