# result = (1..7).select { |x| x.even? }
#                .tap { |x| puts "debug: #{x}" }
#                .reduce do |m, x|
#   m + x
# end

# puts result

def hash_return(params)
  params.tap { |p| p[:page] = 1}
end

p hash_return(per_page: 10)