class Hello
  attr_accessor :list

  def initialize
    @list = ::Array.new # []
  end

  class Array
    # ::Array.new
  end
end

hello = Hello.new
hello.list << 'ruby'
p hello
