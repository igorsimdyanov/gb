# def two(arr)
#   arr.each_with_index do |el, i|
#     return if i >= 2
#     yield el
#   end
# end

# colors = %i[red orange yellow]
# two(colors) { |color| puts color }


def two(arr)
  lb = ->(el, i) do
    return if i >= 2
    yield el
  end
  arr.each_with_index(&lb)
  puts 'hello'
end

colors = %i[red orange yellow]
two(colors) { |color| puts color }
