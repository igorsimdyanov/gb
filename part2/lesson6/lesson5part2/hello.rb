# frozen_string_literal: true

# Класс приветствия
class Hello
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def say
    "Hello, #{name}!"
  end
end

hello = Hello.new('Ruby')
puts hello.say
