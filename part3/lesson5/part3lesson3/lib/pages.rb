# frozen_string_literal: true

require_relative 'seo'

class Page
  attr_accessor :title, :body
end

class News < Page
  attr_accessor :date, :seo
end

class About < Page
  attr_accessor :phones, :address, :seo
end

class PhotoCatalog < Page
  attr_accessor :photos
end
