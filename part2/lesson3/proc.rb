# p ([*1..10].select { |x| x.even? })

# block = Proc.new { |x| x.even? }
# p [*1..10].select(&block) # { |x| x.even? }

p [*1..10].select(&:even?) # :even?.to_proc.call(x)
