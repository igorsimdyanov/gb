require_relative 'ticket'

begin
  10.times.map do |i|
    p Ticket.new(date: Time.new)
  end
rescue => e
  p e
  p e.class
  p e.message
  p e.backtrace
end
