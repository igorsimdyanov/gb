# frozen_string_literal: true

# Универсальный список
class List
  attr_reader :list

  def initialize(*list)
    @list = list
  end

  def each(&block)
    list.each(&block)
  end
end

list = List.new('привет', 'ruby', 'мир', '!')
list.each { |l| puts l }
