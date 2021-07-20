def split_date(str)
  date, time = str.split
  year, month, day = date.split('-', 3).map(&:to_i)
  hours, minutes, seconds = time.split(':', 3).map(&:to_i)

  {
    year: year,
    month: month,
    day: day,
    hours: hours,
    minutes: minutes,
    seconds: seconds
  }
end

date = '2021-07-20 20:45:28'
p split_date(date)
