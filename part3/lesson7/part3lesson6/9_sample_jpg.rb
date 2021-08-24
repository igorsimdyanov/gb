# frozen_string_literal: true

lines = Dir.glob('photos/*.jpg').select { |path| File.file?(path) }
puts lines.sample
