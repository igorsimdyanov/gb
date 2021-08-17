# frozen_string_literal: true

# group of users
class Group
  include Enumerable
  attr_accessor :list

  def initialize
    @list = []
  end

  def <<(user)
    list << user
  end

  def each(&block)
    list.each(&block)
  end

  # single user
  class User
    attr_accessor :name, :email

    def initialize(name:, email:)
      @name = name
      @email = email
    end
  end
end
