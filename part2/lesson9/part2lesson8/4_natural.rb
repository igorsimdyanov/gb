# frozen_string_literal: true

# Животные
class Animalia
end

# Хордовые
class Chordata < Animalia
end

# Млекопитающие
class Mammalia < Chordata
end

# Приматы
class Primates < Mammalia
end

# Гоминиды
class Hominidae < Primates
end

# Люди
class Homo < Hominidae
end

# Человек разумный
class HomoSapiens < Homo
end

NATURAL = [Animalia, Chordata, Mammalia, Primates, Hominidae, Homo, HomoSapiens].freeze
objects = NATURAL.map(&:new)
puts objects
