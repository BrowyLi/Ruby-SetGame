require 'rspec'
require_relative '../lib/card'

describe Card do
  
  describe '::is_set?' do
    subject(:set1) { Card.new(number: "2", color: "red", shading: "solid", shape: "squiggle") }
    subject(:set2) { Card.new(number: "1", color: "green", shading: "solid", shape: "diamond") }
    subject(:set3) { Card.new(number: "3", color: "purple", shading: "solid", shape: "oval") }
    subject(:no_set1) { Card.new(number: "2", color: "red", shading: "solid", shape: "squiggle") }
    subject(:no_set2) { Card.new(number: "1", color: "green", shading: "solid", shape: "squiggle") }
    subject(:no_set3) { Card.new(number: "2", color: "red", shading: "solid", shape: "squiggle") }
    
      
    it 'takes three matching cards, and returns true if they make a set' do
      expect(Card.is_set?(set1, set2, set3)).to be(true)
    end
    
    it 'takes three cards, and returns false if they make a set don\'t make a set' do
      expect(Card.is_set?(no_set1, no_set2, no_set3)).to be(false)
    end
  end
  
  describe '#initialize' do
    subject(:card) { Card.new({color: "red", shape: "squiggle", shading: "solid", number: "1"}) }

    it 'sets up a card correctly' do
      expect(card.color).to eq("red")
      expect(card.shape).to eq("squiggle")
      expect(card.shading).to eq("solid")
      expect(card.number).to eq("1")
    end

    it 'raises an error with an invalid parameter' do
      expect do
        Card.new("periwinkle", "octogon", "polkadots", "43")
      end.to raise_error
    end
  end

end
