# frozen_string_literal: true

require_relative 'lib/unit'

unit = Unit.new

unit << Unit::Employee.new(
  first_name: 'Иван',
  last_name: 'Багреев',
  middle_name: 'Федорович',
  position: :manager
)

unit << Unit::Employee.new(
  first_name: 'Сергей',
  last_name: 'Воронцов',
  middle_name: 'Владимирович',
  position: :backend
)

unit << Unit::Employee.new(
  first_name: 'Юрий',
  last_name: 'Заварский',
  middle_name: 'Александрович',
  position: :backend
)

unit << Unit::Employee.new(
  first_name: 'Ольга',
  last_name: 'Нестеренко',
  middle_name: 'Александровна',
  position: :frontend
)

unit << Unit::Employee.new(
  first_name: 'Владимир',
  last_name: 'Александров',
  middle_name: 'Сергеевич',
  position: :frontend
)

unit << Unit::Employee.new(
  first_name: 'Дмитрий',
  last_name: 'Ермолаев',
  middle_name: 'Данилович',
  position: :qa
)

unit << Unit::Employee.new(
  first_name: 'Роман',
  last_name: 'Наумов',
  middle_name: 'Кириллович',
  position: :designer
)

puts 'Сортированный список'
puts unit.sort
puts 'Backend-разработчики'
puts unit.backend
