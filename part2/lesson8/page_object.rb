# class Page
#   attr_accessor :title, :body, :keywords
# end

class Page #< Object
  attr_accessor :title, :body, :keywords
end

page = Page.new
page.title = 'Какая-то страница'
puts page.title
