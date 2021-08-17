# frozen_string_literal: true

# piece of news
class News
  include Comparable
  attr_accessor :title, :body, :created_at

  def initialize(title:, body:, created_at:)
    @title = title
    @body = body
    @created_at = created_at
  end

  def <=>(other)
    created_at <=> other
  end
end
