require 'rspec'
require_relative '../lib/card'
require_relative '../lib/player'

describe Player do
  subject(:player1) { Player.new("test_player1") }
  subject(:player2) { Player.new("test_player2") }
  let(:set) { [Card.generate_random_card, Card.generate_random_card, Card.generate_random_card] }
  
  describe '#add_set' do  
    it 'adds the set to the sets array' do
      player1.add_set(set)
      
      expect(player1.sets).to eq([set])
    end
  end
  
  describe '#<=>' do
    
    it 'returns 0 when players have the same number of sets' do
      expect(player1 <=> player2).to eq(0)
    end
    
    it 'returns -1 when the player has fewer sets' do
      player2.add_set(set)
      expect(player1 <=> player2).to eq(-1)
    end
    
    it 'returns 1 when the player has more sets' do
      player1.add_set(set)
      expect(player1 <=> player2).to eq(1)
    end
  end
  
end
