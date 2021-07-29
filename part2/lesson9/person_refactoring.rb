class Person
  attr_accessor :name

  def initialize(name:, score:)
    @name = name
    @score = score
  end

  def <=>(person)
    score <=> person.score
  end

  protected

  def score
    @score
  end
end

fst = Person.new(name: 'Первый игрок', score: 12)
snd = Person.new(name: 'Второй игрок', score: 8)

case fst <=> snd
when 1 then puts 'Выигрывает первый игрок'
when -1 then puts 'Выигрывает второй игрок'
when 0 then puts 'Ничья'
end
