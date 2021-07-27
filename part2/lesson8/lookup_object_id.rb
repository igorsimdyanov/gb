class Page
  attr_accessor :title, :body, :keywords
end

class About < Page
  attr_accessor :phones, :address

  def object_id
    'object_id'
  end
end

obj = Object.new
page = Page.new
about = About.new

puts obj.object_id
puts page.object_id
puts about.object_id
