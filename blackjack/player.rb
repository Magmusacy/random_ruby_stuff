# frozen_string_literal: true

require_relative 'displayable'

# This class is used to create and keep track of state of player
class Player
  include Displayable
  attr_accessor :cards, :total

  def initialize
    @cards = []
    @total = 0
  end
end
