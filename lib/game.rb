require_relative './player'
require_relative './deck'
require_relative './board'

class Game
  attr_reader :players, :deck, :board

  def initialize(deck = Deck.new, num_cards_on_board = 12, players = [Player.new("Player1"), Player.new("Player2")])
    @players = players
    @deck = deck
    @board = Board.new(@deck.take(num_cards_on_board))
    @game_over = false
  end
  
  def reset(num_cards_on_board = 12)
    @players, @deck = [Player.new("Player1"), Player.new("Player2")], Deck.new
    @board, @game_over = Board.new(@deck.take(num_cards_on_board)), false
    
    true
  end

  def play
    ARGV.clear
    puts "\nSet Game started!"
    puts "#{@players.count} Players: #{@players.map(&:name).join(", ")}."
    play_round until game_over?
    
    valid_sets
  end
  
  def auto_play
    @players = [Player.new("Computer1"), Player.new("Computer2")]
    
    auto_play_round until game_over?
    
    display_score
    end_game
    
    valid_sets
  end
  
  def valid_sets
    @players.map(&:sets).flatten(1)
  end
  
  def auto_play_round
    set = find_set
    capture_set(@players.first, @board.indices_for(set)) if set
    draw_cards
  end

  def play_round
    # render board
    @board.render
    @deck.render_count
    # Collect input
    input = collect_input until input == 'p' || input == 's' || input == 'q'
    
    case input
    when 's'
      to_draw = pick_set
    when 'p'
      to_draw = true
    when 'q'
      @game_over = true
    end
    
    (end_round(false) && end_game && return) if game_over?
    end_round(to_draw)
  end
  
  def winner_message
    "#{winner.name} wins!\n"
  end
  
  def tied_message
    "All Players Tied!\n"
  end
  
  def tied?
    same_values?(players.map(&:score))
  end
  
  # The player with the most sets wins when the game is over.
  def winner
    players.sort.last
  end

  # The game is over when there are no cards left in the deck, and no sets left on the table.
  def game_over?
    return true if @game_over
    !find_set && @deck.count < 1
  end
  
  # returns true if all values in the array are the same.
  def same_values?(arr)
    arr.uniq.length == 1
  end

  
  # Returns an string of the sets captured by each player
  def sets_captured_message
    @players.map(&:sets_captured_message).join("\n")
  end
  
  def pick_set
    player_name = collect_player_name  until player = @players.find { |p| p.name.downcase == player_name}
    card_indices = collect_indices(player_name) until (card_indices && card_indices.count == 3)
    
    capture_set(player, card_indices) if @board.is_set_at?(card_indices)
  end
  
  def capture_set(player, indices)
    p indices
    player.add_set(@board.remove_cards_at(indices))
  end
  
  def collect_input
    puts "\nEnter 's' for SET or 'p' to Pass and draw more cards, 'q' to Quit:"
    input = gets.chomp.downcase
  end
  
  def collect_player_name
    puts "\nWhich player is this? #{@players.map(&:name).join(", ")}"
    player_name = gets.chomp.downcase
  end
  
  def collect_indices(player_name)
    puts "\n#{player_name}, enter the index of 3 cards separated by spaces (ex: 0 5 9):"
    card_indices = gets.chomp.split(" ").map(&:to_i).uniq
  end
  
  def draw_cards(n = 3)
    begin
      @board.add_cards(@deck.take(n))
    rescue => e
      puts e
    end
    
    true
  end
  
  def display_score
    puts "\n"
    @players.each do |p|
      p.display_score
    end
    puts "\n"
    
    true
  end

  def end_round(to_draw = true)
    display_score
    draw_cards if to_draw
    
    true
  end
 
 def end_game
   puts "Game over!!\n"
   puts (tied? ? tied_message : winner_message)
   puts "Sets Captured: \n #{sets_captured_message}"
   
   return true
 end


  def find_set
    @board.find_set
  end
end

# Cards aren't shuffled so they're easier to find. Also fewer cards total.
def easy
  g = Game.new(Deck.new(Deck.all_cards[0..11]))
  sets = g.play
  
  sets
end


# Full regular shuffled game with 81 card deck.
def hard
  g = Game.new
  sets = g.play
  
  sets
end

def auto
  g = Game.new
  sets = g.auto_play
  
  sets
end

# test_easy

ARGV.each do|a|
  response = self.send(a.to_sym)
end
