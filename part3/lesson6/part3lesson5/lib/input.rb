# frozen_string_literal: true

# input module
module Input
  SIZE = 10

  def self.input_loop
    list = []
    while list.size < SIZE
      str = yield list
      next unless str =~ /\A[a-zа-яё]+\z/i

      list << str
    end
    list
  end
end
