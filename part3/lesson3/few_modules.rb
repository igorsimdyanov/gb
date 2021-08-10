module Seo
  def title
    "Seo#title"
  end
end

module Title
  def title
    "Title#title"
  end
end

class Page
  include Title
  include Seo
end

# page = Page.new
# puts page.title
