# frozen_string_literal: true

# Класс пользователя
class User
  attr_accessor :first_name, :last_name, :middle_name

  def initialize(first_name:, last_name:, middle_name: nil)
    @first_name = first_name
    @last_name = last_name
    @middle_name = middle_name
  end

  def to_s
    [last_name, first_name, middle_name].compact.join(' ')
  end
end
  