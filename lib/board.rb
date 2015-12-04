require_relative './card'
require_relative './deck'

class Board
  attr_reader :cards, :deck

  def initialize(cards = [])
    @cards = cards
  end

  def find_set
    return @cards.combination(3).to_a.find {|x| Card.is_set_array?(x) } || false
  end
  
  def is_set_at?(indices)
    set_cards = self.cards_at(indices)
    is_set = Card::is_set_array?(set_cards)
    puts "Incorrect! Not a set!" unless is_set
    
    is_set
  end
  
  def indices_for(set)
    indices = []
    return indices unless set || set.empty?
    
    set.each do |c|
      indices << @cards.index(c)
    end
    
    indices
  end
  
  def remove_cards(cards)
    @cards -= cards
    
    cards
  end
  
  def remove_cards_at(indices)
    removed = []
    indices.each do |i|
      removed << @cards[i]
    end
    
    remove_cards(removed)
  end
  
  def remove_card_at(i)
    @cards.delete_at(i)
  end
  
  def add_cards(cards_arr)
    puts "\n#{cards_arr.count} new cards added!"
    @cards += cards_arr
  end
  
  # takes an array of indices and returns the cards at those locations
  def cards_at(indices)
    cards = []
    indices.each do |i|
      cards << @cards[i]
    end
    
    cards
  end
  
  def render
    str = "\nBoard:\n"
    @cards.each_with_index do |card, i|
      new_str = card.render(i)
      (34 - new_str.length).times { new_str += " " }
      str += new_str
      str += ((i + 1) % 3 == 0) ? "\n" : "  |  "
    end
    
    puts str + "\n#Cards on board: #{@cards.count}"
  end
end
