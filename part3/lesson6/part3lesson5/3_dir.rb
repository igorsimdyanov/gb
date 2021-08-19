# frozen_string_literal: true

lines = Dir.glob('**/*').select { |path| File.directory?(path) }
puts lines
