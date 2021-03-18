require_relative 'dealer'
require_relative 'player'

# This class handles the game logic, creates player and dealer who then play against themselves, keeps track of the state of each player's cards and announces the winner at the end
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

  def game_loop
    show_decks(:hide_first)
    decision = nil
    until decision == 'stand' || @player.total >= 21
      decision = make_decision
      break if decision == 'stand' # if this is ommited, player can choose to stand and he would still hit
      hit(@player)
      sleep 0.1
      show_decks(:hide_first)
    end

    until @dealer.total >= 17 || @player.total > 21
      hit(@dealer)
      sleep 0.4
      show_decks
    end

  announce_winner
  end

  def hit(recipent)
    @dealer.deal_card(recipent)
  end

  def split; end # i'll maybe add a functionality to split later, or not
  def double; end # i'll maybe add a functionality to double later, or not

  private

  def announce_winner
    range = (0..21)
    p_t = @player.total
    d_t = @dealer.total
    case
    when range.include?(p_t) && range.include?(d_t)
      puts "#{p_t > d_t ? 'Player' : 'Dealer'} wins"
    when range.include?(p_t) && !range.include?(d_t)
      puts 'Player wins'
    when !range.include?(p_t) && range.include?(d_t)
      puts 'Dealer wins'
    end
  end

  def make_decision
    possible_answers = ['hit', 'stand']
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
