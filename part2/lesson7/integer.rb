class Integer
  SEC_PER_MINUTES = 60

  def minutes
    self * SEC_PER_MINUTES
  end
end

puts 10.minutes
