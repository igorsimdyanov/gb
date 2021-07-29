class Person
  attr_accessor :first_name, :last_name, :middle_name, :email

  def initialize(first_name:, last_name:, middle_name:, email:)
    @first_name = first_name
    @last_name = last_name
    @middle_name = middle_name
    @email = email
  end

  # class << self
  #   private :new
  # end
  private_class_method :new
end

user = Person.new(
  first_name: 'Игорь',
  last_name: 'Симдянов',
  middle_name: 'Вячеславович',
  email: 'igorsimdyanov@gmail.com'
)

p user
