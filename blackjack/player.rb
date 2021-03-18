require_relative 'displayable'

class Player
  include Displayable
  attr_accessor :cards, :total

  def initialize
    @cards = []
    @total = 0
  end
end
