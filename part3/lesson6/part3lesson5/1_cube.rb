# frozen_string_literal: true

require_relative 'lib/cube'

fst = Cube.instance(1, 1, 1, 3)
snd = Cube.instance(1, 1, 1, 3)
thd = Cube.instance(0, 0, 0, 3)
p fst
p snd
p thd
puts fst.volume
