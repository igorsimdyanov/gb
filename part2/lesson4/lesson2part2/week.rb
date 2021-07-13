# frozen_string_literal: true

WEEK = %w[
  понедельник
  вторник
  среда
  четверг
  пятница
  суббота
  воскресенье
].freeze

puts(WEEK.select { |day| day.downcase.start_with? 'с' })
