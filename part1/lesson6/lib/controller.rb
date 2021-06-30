# frozen_string_literal: true

# Controller
class Controller
  def check(user)
    @user = user
    if @user.ticket
      puts 'Билет в наличие'

      check_name
      check_date
    else
      puts 'Нет билета'
    end
  end

  def check_name
    puts 'Билет на имя пользователя' if @user.ticket.name == @user.name

    puts 'Билет на чужое имя'
  end

  def check_date
    if @user.ticket.date == Date.today
      puts 'Билет на сегодняшнюю дату'
    else
      puts 'Билет на другую дату'
    end
  end
end
