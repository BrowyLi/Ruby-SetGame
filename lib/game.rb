require_relative './player'
require_relative './deck'
require_relative './board'

class Game
  attr_reader :players, :deck, :board

  def initialize(deck = Deck.new)
    @players = [Player.new("Player1"), Player.new("Player2")]
    @deck = deck
    @board = Board.new(@deck.take(12))
    @game_over = false
  end

  def play
    puts "\nSet Game started!"
    puts "#{@players.count} Players: #{@players.map(&:name).join(", ")}."
    play_round until game_over?
    game_over?
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
      to_draw = skip_turn
    when 'q'
      @game_over = true
    end
    
    (end_round(false) && render_game_over && return) if game_over?
    end_round(to_draw)
  end
  
  def render_game_over
    puts "Game over!!\n"
    puts "#{winner.name} wins!\n"
    puts "Sets Captured: \n #{sets_captured.join("\n")}"
    return true
  end
  
  def sets_captured
    @players.map(&:sets_captured_message)
  end
  
  def skip_turn
    true
  end
  
  def pick_set
    player_name = collect_player_name  until player = @players.find { |p| p.name.downcase == player_name}
    card_indices = collect_indices(player_name) until (card_indices && card_indices.count == 3)
    
    capture_set(player, card_indices) if @board.is_set_at?(card_indices)
  end
  
  def capture_set(player, indices)
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
    card_indices = gets.chomp.split(" ").map(&:to_i)
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
    # Display sets
    sets = {}
    @players.each do |p|
      sets[p.name] = []
      p.sets.each do |s|
        sets[p.name] << s.map(&:to_s)
      end
    end
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
  
  def find_set
    @board.find_set
  end
end

def test_easy
  g = Game.new(Deck.new(Deck.all_cards[0..11]))
  g.play
end

def test_full
  g = Game.new
  g.play
end
