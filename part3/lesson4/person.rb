class Person
  attr_accessor :first_name, :last_name, :middle_name
  attr_reader :password

  def initialize(first_name, last_name, middle_name, password)
    @first_name = first_name
    @last_name = last_name
    @middle_name = middle_name
    @password = password
  end

  def marshal_dump
    [@first_name, @last_name, @middle_name]
  end

  def marshal_load(list)
    @first_name, @last_name, @middle_name = list
  end
end

person = Person.new(
           'Иван',
           'Петрович',
           'Сидоров',
           'qwerty'
         )

str = Marshal.dump(person)
p str
prsn = Marshal.load(str)

p prsn.first_name
p prsn.last_name
p prsn.middle_name
p prsn.password
