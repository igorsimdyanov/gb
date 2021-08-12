require 'singleton'
require 'forwardable'

class Settings
  include Singleton
  extend Forwardable
  attr_reader :list
  def_delegators :@list, :[]=, :[]
  # delegate :[]= => :@list, :[] => :@list

  def initialize
    @list = {}
  end
end

s = Settings.instance
s[:title] = 'Новостной портал'
s[:per_page] = 30
p s

f = Settings.instance
puts f[:title]
puts f[:per_page]
