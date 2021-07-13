# frozen_string_literal: true

PLANETS = {
  'Меркурий' => 0.32868,
  'Венера' => 4.81068,
  'Земля' => 5.97600,
  'Марс' => 0.63345,
  'Юпитер' => 1876.64328,
  'Сатурн' => 561.80376,
  'Уран' => 86.05440,
  'Нептун' => 101.59200,
  'Плутон' => 0.01195
}.freeze

# [['Меркурий', 0.32868], ... ]

puts 'Легкие'
p PLANETS.sort_by { |_k, v| v }.take(3).map(&:first)
puts 'Тяжелые'
p PLANETS.sort_by { |_k, v| v }.reverse.take(3).map(&:first)
