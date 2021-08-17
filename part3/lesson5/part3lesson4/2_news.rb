# frozen_string_literal: true

require_relative 'lib/news'

first = News.new(
  title: 'Ruby 3.0',
  body: 'Вышел Ruby 3.0',
  created_at: Time.mktime(2020, 12, 20)
)

second = News.new(
  title: 'Ruby on Rails 6.1',
  body: 'Вышел Ruby on Rails 6.1',
  created_at: Time.mktime(2020, 11, 20)
)

p first >= second
