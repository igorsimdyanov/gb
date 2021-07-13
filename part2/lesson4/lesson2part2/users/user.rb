# frozen_string_literal: true

# User class
class User
  def initialize(mark, first_name, last_name, middle_name = nil)
    @mark = mark
    @first_name = first_name
    @last_name = last_name
    @middle_name = middle_name
  end

  def to_s
    [first_name, middle_name, last_name, "(#{mark})"].join(' ')
  end

  attr_reader :mark, :first_name, :last_name, :middle_name
end

# UserList
class UserList
  def initialize(number = 10, max_mark = 5)
    @list = (1..number).each_with_object([]) do |_e, m|
      m << User.new(
        rand(1..max_mark),
        FFaker::Name.first_name,
        FFaker::Name.last_name,
        FFaker::Name.first_name
      )
    end
  end

  attr_accessor :list
end
