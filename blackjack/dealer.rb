# frozen_string_literal: true

require_relative 'displayable'

# This class handles drawing cards from the deck, dealing the card to the player/dealer, and ace card behaviour
class Dealer
  include Displayable
  attr_accessor :cards, :total
  DECK = [2, 3, 4, 5, 6, 7, 8, 9, { king: 10, queen: 10, jack: 10 }, { ace: Array(1..11) }].freeze
  BLACKJACK = 21

  def initialize
    @cards = []
    @total = 0
  end

  def deal_card(recipent)
    new_card = Dealer.draw_random_card
    new_card = new_card.is_a?(Array) ? ace_card_behaviour(recipent, new_card) : new_card
    recipent.cards << new_card
    recipent.total += new_card
  end

  def self.draw_random_card
    card = DECK.sample
    card = card.is_a?(Hash) ? card[card.keys.sample] : card
    card
  end

  private

  # this isn't quite right becase ace isn't calculated the moment it is given
  # but i don't wanna get too much into the rules right now
  def ace_card_behaviour(recipent, ace_card)
    returnable_ace_card = [BLACKJACK - recipent.cards.sum] & ace_card
    returnable_ace_card.is_a?(Array) ? ace_card.max : returnable_ace_card
  end
end
