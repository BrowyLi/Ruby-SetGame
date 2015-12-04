require_relative './card'

class Deck
  
  def self.attri
    @attri ||= Card::ATTRIBUTES
  end
  
  def self.all_attributes
    attri[:color].product(attri[:shape].product(attri[:shading].product(attri[:number]))).map(&:flatten)
  end

  # Returns 81 unique cards in order.
  def self.all_cards
    cards = []
    
    all_attributes.each do |attr_arr|
      cards << Card.new(color: attr_arr[0], shape: attr_arr[1], shading: attr_arr[2], number: attr_arr[3])
    end
    
    cards
  end
  
  def initialize(cards = Deck.all_cards.shuffle)
    @cards = cards.dup
  end

  def count
    @cards.count
  end
  
  def render_count
    puts "#Cards in deck: #{count}"
  end

  def take(n)
    if n > count
      take!(count)
      raise "Not enough cards left in the deck to draw."
    end
    
    take!(n)
  end

  def return(cards)
    @cards.push(*cards)
  end
  
  def take!(n)
    @cards.shift(n)
  end

  def shuffle
    @cards.shuffle!
  end
end
