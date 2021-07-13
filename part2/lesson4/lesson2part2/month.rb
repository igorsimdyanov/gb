# frozen_string_literal: true

MONTHES = %w[
  январь
  февраль
  март
  апрель
  май
  июнь
  июль
  август
  сентябрь
  октябрь
  ноябрь
  декабрь
].freeze

puts MONTHES.min_by(&:size)
puts MONTHES.max_by(&:size)
