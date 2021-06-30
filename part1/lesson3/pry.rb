# frozen_string_literal: true

require 'pry-byebug'

class Hello
  def greeting
    'Hello, world!'
  end
end

h = Hello.new
o = Object.new

binding.pry

puts h.greeting

binding.pry

puts o.greeting
