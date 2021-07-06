# frozen_string_literal: true

def leap_year?(year)
  return if year % 4 != 0 || ((year % 100).zero? && year % 400 != 0)

  true
end

years = [1600, 1900, 2000, 2020, 2021]

years.each do |year|
  if leap_year?(year)
    puts "Год #{year} високосный"
  else
    puts "Год #{year} не високосный"
  end
end
