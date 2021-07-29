class Settings
  def initialize
    @list = {}
  end

  def self.instance
    @@obj ||= new
  end

  def dup
    @@obj
  end

  def []=(key, value)
    @list[key] = value
  end

  def [](key)
    @list[key]
  end

  private_class_method :new
  alias clone dup
end

settings = Settings.instance
settings[:title] = 'Новостной портал'
settings[:per_page] = 30

params = Settings.instance
puts params[:title]
puts params[:per_page]
p params[:per_page1] # nil
