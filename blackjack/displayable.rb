# frozen_string_literal: true

require 'colorize'

# This module handles displaying cards to a user, hiding dealer's card when player is currently in control
module Displayable
  def show_cards(state = :show_first)
    cards, color, total = card_presentation(state)
    print "#{self.class}'s cards ---> ".send(color)
    cards.count.times do |i|
      print "#{'['.bold} |#{cards[i].to_s.send(color)}| #{']'.bold}"
    end
    print " <--- #{total}\n".send(color)
  end

  def hide_dealer_card(cards)
    dealer_deck = cards.dup
    dealer_deck[0] = 'X'
    dealer_deck
  end

  def show_hidden_total
    total - cards.first
  end

  def card_presentation(state)
    if is_a?(Dealer)
      return state == :hide_first ? [hide_dealer_card(cards), :yellow, show_hidden_total] : [cards, :yellow, total]
    end

    [cards, :blue, total]
  end
end
