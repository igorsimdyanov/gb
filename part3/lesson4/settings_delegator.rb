require 'singleton'
require 'forwardable'

class Settings
  include Singleton
  extend Forwardable
  attr_reader :list
  def_delegator :@list, :[]=, :set
  def_delegator :@list, :[], :get

  def initialize
    @list = {}
  end
end

s = Settings.instance
s.set(:title, 'Новостной портал')
s.set(:per_page, 30)
p s

f = Settings.instance
puts f.get(:title)
puts f.get(:per_page)
