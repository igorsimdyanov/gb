module Site
  VERSION = '1.1.0'

  def greeting(str)
    "Hello, #{str}!"
  end

  class Settings
    VERSION = '1.2.0'
    def self.per_page
      20
    end
  end
end
