# frozen_string_literal: true

class Unit
  # Employee class
  class Employee
    attr_accessor :first_name, :last_name, :middle_name, :position

    ROLES = %i[manager backend frontend qa designer].freeze

    def initialize(first_name:, last_name:, middle_name:, position:)
      @first_name = first_name
      @last_name = last_name
      @middle_name = middle_name

      raise 'Недопустимая роль в команде' unless ROLES.include? position

      @position = position
    end

    def to_s
      [last_name, first_name, middle_name].join(' ') + " (#{position})"
    end
  end
end
