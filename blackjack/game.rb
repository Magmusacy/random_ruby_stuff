# frozen_string_literal: true

require_relative 'dealer'
require_relative 'player'

# This class handles the game logic, creates player and dealer who then play against themselves
# keeps track of the state of each player's cards and announces the winner at the end
class Game
  def initialize
    @player = Player.new
    @dealer = Dealer.new
    2.times do
      hit(@player)
      hit(@dealer)
    end
    game_loop
  end

  def hit_and_show_decks(state, receiver)
    yield # yield the block given when calling method
    hit(receiver)
    sleep 0.4
    show_decks(state)
  end

  def player_turn
    decision = nil
    until decision == 'stand' || @player.total >= 21
      hit_and_show_decks(:hide_first, @player) do
        decision = make_decision
        break if decision == 'stand' # if this is ommited, player can choose to stand and he would still hit
      end
    end
  end

  def dealer_turn
    hit_and_show_decks(:show_first, @dealer) { nil } until @dealer.total >= 17 || @player.total > 21
  end

  def game_loop
    show_decks(:hide_first)
    player_turn
    dealer_turn
    announce_winner
  end

  def hit(recipent)
    @dealer.deal_card(recipent)
  end

  # i'll maybe add a functionality to split later, or not
  def split; end

  # i'll maybe add a functionality to double later, or not
  def double; end

  private

  def announce_winner
    show_decks
    range = (0..21)
    if range.include?(@player.total)
      puts 'Player wins' unless range.include?(@dealer.total)
      puts "#{@player.total > @dealer.total ? 'Player' : 'Dealer'} wins" if range.include?(@dealer.total)
    elsif range.include?(@dealer.total)
      puts 'Dealer wins'
    end
  end

  def make_decision
    possible_answers = %w[hit stand]
    print 'Choose between |hit| or |stand|: '
    answer = gets.chomp.downcase
    possible_answers.include?(answer) ? answer : make_decision
  end

  def show_decks(state = :show_first)
    @player.show_cards
    @dealer.show_cards(state)
    puts
  end
end

Game.new
