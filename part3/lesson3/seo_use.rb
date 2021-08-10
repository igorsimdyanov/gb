require_relative 'seo_module'

class Page
  include Seo
  extend Seo::ClassMethods
end

p Page.instance_methods
p Page.methods
