# p [1, 2, 3, 4, 5].select { |x| x.even? }
p [1, 2, 3, 4, 5].select(&:even?)
