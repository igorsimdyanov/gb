module Seo
  # include
  attr_accessor :meta_title, :meta_description, :meta_keywords

  module ClassMethods
    # extend
    def title(name)
      "Программирование на Ruby. #{name}"
    end
    
    def say(name)
      "Hello, #{name}!"
    end
  end
end