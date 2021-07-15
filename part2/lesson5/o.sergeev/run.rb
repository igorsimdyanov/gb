# frozen_string_literal: true

require 'date'

puts `clear`
# Task 1
puts "\nTask 1"
def week_dates(week_num, &block)
  return unless block_given?

  start = Date.commercial(Time.now.year, week_num, 1)
  finish = Date.commercial(Time.now.year, week_num, 7)
  (start..finish).to_a.each(&block)
end

week_dates(10) { |date| puts date }

# Task 2
puts "\nTask 2"
def weekends(year)
  return unless block_given?

  (Date.new(year, 1, 1)..Date.new(year, 12, 31)).to_a.each do |date|
    yield date if [6, 7].include?(date.cwday)
  end
end

weekends(2021) { |date| puts date }

# Task 3
puts "\nTask 3"
def walk(array, &block)
  return unless block_given?

  array.each do |arr|
    walk(arr) if arr.instance_of?(Array) # to_ary
    arr.each(&block)
  end
end

arr = [[[1, 2], 3], [4, 5, 6], [7, [8, 9], [10, [11, 12]]]]
walk(arr) { |i| puts i }

# Task 4
puts "\nTask 4"
def add_function(num)
  return @y if num == @num_to_f

  @x, @y = @y, (@x + @y)
  @arr.push(@y)
  num += 1
  add_function(num)
end

def fibonacci(num_to_f, &block)
  @x = 0
  @y = 1
  @num_to_f = num_to_f
  @arr = []
  add_function(1)
  return if block_given? && !@arr.each(&block)
end
fibonacci(10) { |f| print "#{f} " }

# Task 5
puts "\nTask 5"
# class Array
class Array
  def my_map(&block)
    new_array = []
    each do |element|
      new_array.push(block.call(element))
    end
    new_array
  end
end

new_arr = [1, 2, 3, 4, 5].my_map { |x| x * x }
p new_arr

new_arr2 = [1, 2, 3].my_map(&:to_f)
p new_arr2

# Task 6
puts "\nTask 6"
# class Array
class Array
  def my_select(&block)
    new_array = []
    each do |element|
      res = block.call(element)
      new_array.push(element) if res
    end
    new_array
  end
end

new_arr = [1, 2, 3, 4, 5, 6, 7, 8, 9].my_select(&:even?)
p new_arr

# Task 7
puts "\nTask 7"
# class Array
class Array
  def my_reduce(fst_param = nil, &block)
    sum = fst_param || first
    each do |element|
      sum ||= element
      sum = block.call(sum, element)
    end
    sum
  end
end

p [1, 3, 5].my_reduce { |sum, n| sum + (n * 3) }
# p [1, 3, 5].my_reduce(0) { |sum, n| sum + (n * 3) }
# p [1, 3, 5].my_reduce(10) { |sum, n| sum + (n * 3) }

# 0 + (1 * 3) = 3
# 3 + (3 * 3) = 12
# 12 + (5 * 3) = 27

# 1 + (1 * 3) = 4
# 4 + (3 * 3) = 13
# 13 + (5 * 3) = 28

# 10 + (1 * 3) = 13
# 13 + (3 * 3) = 22
# 22 + (5 * 3) = 37
