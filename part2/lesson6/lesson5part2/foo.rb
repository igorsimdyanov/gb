# frozen_string_literal: true

# Класс Foo
class Foo
  attr_accessor :options

  def initialize(options)
    @options = options
  end

  def method_missing(name)
    options[name] if options.key? name
  end

  def respond_to_missing?(method_name, include_private = false)
    options.keys.include?(method_name) || super
  end
end

foo = Foo.new(fst: :hello, snd: :world, counter: 235)

puts foo.fst
puts foo.snd
puts foo.counter
puts foo.unknown

p foo.respond_to? :fst
