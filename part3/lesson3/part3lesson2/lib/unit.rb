# frozen_string_literal: true

require_relative 'unit/employee'

# Development team
class Unit
  attr_accessor :list

  def initialize
    @list = []
  end

  def <<(employee)
    list << employee
  end

  def sort
    list.sort_by(&:to_s)
  end

  Employee::ROLES.each do |role|
    define_method role do
      list.select { |e| e.position == role }.sort_by(&:to_s)
    end
  end
end
