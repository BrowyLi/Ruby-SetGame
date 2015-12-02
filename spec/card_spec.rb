require 'rspec'
require 'card'

describe Card do
  
  describe '::is_set?' do
    subject(:set1) { Card.new(number: "2", color: "red", shading: "solid", shape: "squiggle") }
    subject(:set2) { Card.new(number: "1", color: "green", shading: "solid", shape: "diamond") }
    subject(:set3) { Card.new(number: "3", color: "purple", shading: "solid", shape: "oval") }
    subject(:no_set1) { Card.new(number: "2", color: "red", shading: "solid", shape: "squiggle") }
    subject(:no_set2) { Card.new(number: "1", color: "green", shading: "solid", shape: "squiggle") }
    subject(:no_set3) { Card.new(number: "2", color: "red", shading: "solid", shape: "squiggle") }
    
      
    it 'returns true when 3 cards make a set' do
      expect(Card.is_set?(set1, set2, set3)).to be(true)
    end
    
    it 'returns false when 3 cards don\'t make a set' do
      expect(Card.is_set?(no_set1, no_set2, no_set3)).to be(false)
    end
  end
  
  describe '#initialize' do
    # subject(:card) { Card.new(:spades, :ten) }

    it 'sets up a card correctly' do
      # expect(card.suit).to eq(:spades)
#       expect(card.value).to eq(:ten)
    end

    it 'raises an error with an invalid suit' do
      # expect do
  #       Card.new(:test, :ten)
  #     end.to raise_error
    end

    it 'raises an error with an invalid value' do
      # expect do
 #        Card.new(:spades, :test)
 #      end.to raise_error
    end
  end

end
