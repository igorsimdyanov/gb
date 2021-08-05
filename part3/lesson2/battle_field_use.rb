require_relative 'game/battle_field'

# Создание объекта
battle_field = BattleField.new(size: BattleField::Ship::SIZE) do |size|
  Array.new(size) do |y|
    Array.new(size) do |x|
      BattleField::Field.new(x: BattleField::Ship::X[x], y: y + 1)
    end
  end
end

puts battle_field
