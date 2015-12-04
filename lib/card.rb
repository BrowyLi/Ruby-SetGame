class Card
  include Comparable

  ATTRIBUTES = {
    :color    => ["red", "green", "purple"],
    :shape => ["diamond", "squiggle", "oval"],
    :shading   => ["solid", "empty", "striped"],
    :number   => ["1","2","3"]
  }

  def self.test
    set = []
    set << Card.new(number: "2", color: "red", shading: "solid", shape: "squiggle")
    set << Card.new(number: "1", color: "green", shading: "solid", shape: "diamond")
    set << Card.new(number: "3", color: "purple", shading: "solid", shape: "oval")
    puts "Set found? #{Card.is_set?(set[0], set[1], set[2])}"
  
    no_set = []
    no_set << Card.new(number: "2", color: "red", shading: "solid", shape: "squiggle")
    no_set << Card.new(number: "1", color: "green", shading: "solid", shape: "squiggle")
    no_set << Card.new(number: "3", color: "purple", shading: "solid", shape: "oval")
    puts "Set found? #{Card.is_set?(no_set[0], no_set[1], no_set[2])}"  
  end
  
  def self.color
    ATTRIBUTES[:color]
  end
  
  def self.shape
    ATTRIBUTES[:shape]
  end
  
  def self.shading
    ATTRIBUTES[:shading]
  end
  
  def self.number
    ATTRIBUTES[:number]
  end
  
  def self.attribute_names
    ATTRIBUTES.keys
  end
  
  def self.random_attr_hash(col = color.sample, shap = shape.sample, shad = shading.sample, num = number.sample)
    {color: col, shape: shap, shading: shad, number: num}
  end

  def self.generate_random_card
    Card.new(random_attr_hash)
  end
  
  def self.generate_random_cards(n)
    cards = []
    n.times { cards << self.generate_random_card}
    
    cards
  end

  def self.validate(attributes)
    attributes.each do |k, v|
      raise "illegal #{k} (#{v.inspect})" unless Card::ATTRIBUTES[k].include?(v)
    end
  end
  
  # Three cards  are a part of a set if, for each property, the values are all the same or all different.
  
  # TODO: Given more time, I would move this logic into a Set class consisting of 3 cards, these validations
  # and helper methods.
  
  # A method that takes three cards, and determines whether the three cards make a set
  def self.is_set?(card1, card2, card3)
    cards_array = [card1, card2, card3]
    is_set_array?(cards_array)
  end
  
  def self.is_set_array?(cards_array)
    attribute_names.each do |attribute|
      attr_array = cards_array.map(&attribute)
      unless all_same?(attr_array) || all_different?(attr_array)

        return false 
      end
    end
    
    return true
  end
  
  def self.all_same?(array)
    # quits as soon as it finds
    (array[1..-1].find{ |x| x != array.first }) ? false : true
  end
  
  def self.all_different?(array)
    array.uniq.size == array.size
  end
  
  attr_reader :color, :shape, :shading, :number

  def initialize(attributes)
    self.class.validate color: attributes[:color], shape: attributes[:shape], shading: attributes[:shading], number: attributes[:number]

    @color, @shape, @shading, @number = attributes[:color].to_s, attributes[:shape].to_s, attributes[:shading].to_s, attributes[:number].to_s
  end

  def to_s
    "#{@color} #{@shape} #{@shading} #{@number}"
  end
  
  def render(i)
    "[#{self} (i: #{i})]"
  end

  def ==(other_card)
    (self.to_s == other_card.to_s)
  end
  
  def <=>(other_card)
    (self.to_s <=> other_card.to_s)
  end
end
