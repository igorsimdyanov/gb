# frozen_string_literal: true

require_relative 'lib/fivable'

# Example class
class Hello
  include Fivable

  def say(name)
    "Hello, #{name}!"
  end
end

array = Array.new(13) { Hello.new }
p array
