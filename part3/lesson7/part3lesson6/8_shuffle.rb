# frozen_string_literal: true

lines = File.readlines('filename.txt').map(&:chomp)
File.write('filename.txt', lines.shuffle.join("\n"))
