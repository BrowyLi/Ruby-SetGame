require 'rspec'
require_relative '../lib/game'

describe Game do
  subject(:game) { Game.new }
  let(:no_set) { [
    Card.new(number: "2", color: "red", shading: "solid", shape: "squiggle"),
    Card.new(number: "1", color: "green", shading: "solid", shape: "squiggle"),
    Card.new(number: "3", color: "purple", shading: "solid", shape: "oval")
    ]
  }
  let(:set) { [
    Card.new(number: "2", color: "red", shading: "solid", shape: "squiggle"),
    Card.new(number: "1", color: "green", shading: "solid", shape: "diamond"),
    Card.new(number: "3", color: "purple", shading: "solid", shape: "oval")
    ]
  }

  describe '#deck' do
    it 'should start with a deck' do
      expect(game.deck).to be_a(Deck)
    end

    it 'should start with a full deck' do
      expect(game.deck.count).to eq(81 - 12)
    end
  end

  describe '#game_over?' do

    it 'should return false when there are sets on the board' do
      game = Game.new(Deck.new(set), 3)
      expect(game).not_to be_game_over
    end
    
    it 'should return false when there are cards left in the deck to draw' do
      game = Game.new(Deck.new(no_set), 0)
      expect(game).not_to be_game_over
    end

    it 'should return true when no sets are left on the board and no cards remain in the deck' do
      game = Game.new(Deck.new(no_set), 3)
      expect(game).to be_game_over
    end
  end
  
  describe '#winner' do
    it 'should return false when there are sets on the board' do
      game = Game.new(Deck.new(set), 3)
      expect(game).not_to be_game_over
    end
  end
  
  describe '#tied?' do
    it 'should return true if all players have the same score' do
      game = Game.new
      expect(game).to be_tied
    end
    
    it 'should return false if players have different scores' do
      game = Game.new(Deck.new(set), 3, [Player.new("Player1", set), Player.new("Player2")])
      expect(game).not_to be_tied
    end
  end
end
