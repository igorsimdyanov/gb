class Person
  attr_accessor :name

  def initialize(name:, score:)
    @name = name
    @score = score
  end

  def >(person)
    score > person.score
  end

  def <(person)
    score < person.score
  end

  protected # self.score, person.score

  def score
    @score
  end
end

fst = Person.new(name: 'Первый игрок', score: 12)
snd = Person.new(name: 'Второй игрок', score: 8)

if fst > snd
  puts 'Выигрывает первый игрок'
elsif fst < snd
  puts 'Выигрывает второй игрок'
else
  puts 'Ничья'
end
