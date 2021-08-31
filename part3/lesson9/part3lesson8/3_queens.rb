# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)
require 'deep_clone'
require_relative 'chess/board'

boards = (0...Board::MAX_POSITION).map { |x| [x, Board.new] }.to_h

acc = {}
line = 0
boards.each do |x, b|
  next unless b.check?(x, line)

  board = DeepClone.clone(b)
  board.set_queen(x, line)
  acc["#{x};#{line}"] = board
end
boards = acc

(1...Board::MAX_POSITION).each do |row|
  acc = {}
  boards.each do |prev_keys, b|
    (0...Board::MAX_POSITION).each do |x|
      next unless b.check?(x, row)

      board = DeepClone.clone(b)
      board.set_queen(x, row)
      acc["#{prev_keys}-#{x};#{row}"] = board
    end
  end
  boards = acc
end

p boards.count
# board = Board.new
# board.set_queen(0, 0)
# #p board.check?(2, 1)
# board.set_queen(2, 1)
# board.set_queen(4, 2)
# board.set_queen(1, 3)
# board.set_queen(3, 4)
# puts board
# p board.check?(3, 4)
# puts board
