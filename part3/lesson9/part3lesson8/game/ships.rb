# frozen_string_literal: true

class Ships
  ONE_DECK_NUMBER = 4
  TWO_DECK_NUMBER = 3
  THREE_DECK_NUMBER = 2
  FOUR_DECK_NUMBER = 1

  def self.how_many(decks)
    [ONE_DECK_NUMBER, TWO_DECK_NUMBER, THREE_DECK_NUMBER, FOUR_DECK_NUMBER][decks - 1]
  end
end
