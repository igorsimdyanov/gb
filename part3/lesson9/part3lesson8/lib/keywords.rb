# frozen_string_literal: true

require 'set'
require 'forwardable'

# keywords class
class Keywords
  attr_accessor :keywords

  extend Forwardable
  def_delegators :@keywords, :<<, :delete

  def initialize(keywords = [])
    @keywords = ::Set.new(keywords)
  end
end
