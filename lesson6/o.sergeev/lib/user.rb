# frozen_string_literal: true

# Class User
class User
  @@counter = 0

  attr_accessor :name, :surname, :patronimyc

  def initialize(name, surname, patronimyc)
    @name = name
    @surname = surname
    @patronimyc = patronimyc
    @@counter += 1
  end

  def counter
    @@counter
  end
end
