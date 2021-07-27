# frozen_string_literal: true

class User
  attr_accessor :name, :surname, :patronymic, :email

  def initialize
    yield self
  end
end
