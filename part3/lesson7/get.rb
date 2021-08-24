# h = { first: 1, second: 2}

# p h[:first] # 1
# p h[:first] + h[:second] # 3

# p h.fetch(:third, 0)
# p h.fetch(:third) { |x| "Ключ #{x} не существует" }

settings = {
  title: 'Новости',
  paginate: {
    per_page: 30,
    max_page: 10
  }
}

p settings[:paginate][:max_page]
p settings[:paginate][:max_page1]
# p settings[:paginate][:max_page1][:total]
p settings.dig(:paginate, :max_page1, :total)
