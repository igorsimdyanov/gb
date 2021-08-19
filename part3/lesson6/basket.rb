arr = %w[Иванов Петров Сидоров Тарасов Кожевин]

puts arr[0]  # Иванов
puts arr[3]  # Тарасов
puts arr[4]  # Кожевин
puts arr[-1] # Кожевин

p arr[1..3]  # ["Петров", "Сидров", "Тарасов"]
p arr[1...3] # ["Петров", "Сидров"]
p arr[1..-2] # ["Петров", "Сидров", "Тарасов"]

p arr[1, 1]
p arr[2, 3]