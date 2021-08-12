require 'singleton'

class Settings
  include Singleton
  attr_reader :list

  def initialize
    @list = {}
  end

  def [](key)
    list[key]
  end

  def []=(key, value)
    list[key] = value
  end
end

s = Settings.instance
s[:title] = 'Новостной портал'
s[:per_page] = 30
p s

f = Settings.instance
puts f[:title]
puts f[:per_page]

p f.class.new
