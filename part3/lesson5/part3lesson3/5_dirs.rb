# frozen_string_literal: true

dir_size = Dir.glob('**/*').select { |path| File.file?(path) }
              .reduce(0) { |size, path| size + File.size(path) }
p dir_size
