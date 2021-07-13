# frozen_string_literal: true

# Class of colors list
class Color
  def self.list(prompt = '> ', stop = 'stop')
    (1..).each_with_object([]) do |_i, m|
      print prompt
      str = gets.chomp
      return m if str.downcase == stop

      m << str
    end
  end
end
