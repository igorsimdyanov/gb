require_relative 'ticket'

begin
  10.times.map do |i|
    p Ticket.new(date: Time.new)
  end
rescue
  puts 'Произошла ошибка'
end
