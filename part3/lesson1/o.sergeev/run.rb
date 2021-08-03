# frozen_string_literal: true

require 'singleton'

# class Singleton
class MyClass
  include Singleton

  # @instance = new

  # class << self
  #   attr_reader :instance
  # end

  # def dup
  #   self
  # end

  def some_data
    "Object made by: #{self.class.name}"
  end

  # alias clone dup
end

first = MyClass.instance
p "Object '#{first}'"
p first.some_data
p "Object_id '#{first.object_id}'"
second = MyClass.instance
p "Object '#{second}'"
p second.some_data
p "Object_id '#{second.object_id}'"
p second.dup
p second.clone
