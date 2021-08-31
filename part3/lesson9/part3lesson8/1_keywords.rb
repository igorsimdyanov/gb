# frozen_string_literal: true

require_relative 'lib/keywords'

seo = Keywords.new ['Ruby on Rails', 'Ruby', 'bundler']

seo << 'Ruby'
seo << 'rbenv'
seo << 'rvm'

p seo.keywords
