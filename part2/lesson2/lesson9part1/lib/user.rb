# frozen_string_literal: true

# User class
class User
  def initialize(surname, name, patronymic)
    @name = name
    @surname = surname
    @patronymic = patronymic
  end

  attr_reader :name, :surname, :patronymic
end
