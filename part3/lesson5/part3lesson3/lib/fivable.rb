# frozen_string_literal: true

# rubocop:disable Style/ClassVars
# Only 5 instance per class
module Fivable
  def self.included(klass)
    klass.class_exec do
      @@counter = 0
      def initialize
        @@counter += 1
        raise 'Five objects are allowed only' if @@counter > 4
      end
    end
  end
end
# rubocop:enable Style/ClassVars
