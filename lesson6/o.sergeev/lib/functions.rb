# frozen_string_literal: true

require 'io/console'

MESSAGE_PRESS_ANY_KEY = "\nPress any key or 'q' for exit: "
MESSAGE_ABORT = 'Bye, bye!'

def presskey
  print MESSAGE_PRESS_ANY_KEY
  input = $stdin.getch
  abort MESSAGE_ABORT if input == 'q'
  puts `clear`
end
