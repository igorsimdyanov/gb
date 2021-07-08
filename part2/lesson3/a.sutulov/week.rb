# frozen_string_literal: true

class Week
  ONE_DAY = 86_400
  WEEK_OF_DAY = 7

  def self.beging_of_week(today)
    med = WEEK_OF_DAY - (today.strftime '%u').to_i
    today - med * ONE_DAY
  end

  def self.call
    today = Time.now
    Array.new(WEEK_OF_DAY) { |i| beging_of_week(today) + i * ONE_DAY }
            .map { |day| day.strftime '%d.%m.%Y' }
  end
end

puts Week.call
