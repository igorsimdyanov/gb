class Singleton
  def self.instance
    @@obj ||= new # @obj = @obj || new
  end

  def dup
    @@obj
  end

  private_class_method :new
  alias clone dup
end

first = Singleton.instance
p first

second = Singleton.instance
p second

third = Singleton.instance
p third

p first.dup
p first.clone
