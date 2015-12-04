require 'rspec'
require_relative '../lib/board'

describe Board do
  let(:cards) { Deck.new.take(12) }
  
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

  subject(:board) { Board.new(cards) }
  subject(:set_board) { Board.new(set)}
  subject(:empty_board) { Board.new }

  describe '#initialize' do
    it 'accepts cards correctly' do
      expect(board.cards).to match_array(cards)
    end

    it 'assigns empty array when no arguments are given' do
      expect(empty_board.cards).to eq([])
    end
  end
  
  describe "#find_set" do
    it "finds a set if there is one on the board" do
      expect(set_board.find_set).to eq(set)
    end
    
    it "returns false when there is no set" do
      expect(empty_board.find_set).to be false
    end
  end
end