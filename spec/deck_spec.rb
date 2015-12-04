require 'rspec'
require_relative '../lib/deck'

describe Deck do
  describe "::all_cards" do
    subject(:all_cards) { Deck.all_cards }

    it "should generate 81 unique cards" do
      expect(all_cards.count).to eq(81)
    end

    it "returns all cards without duplicates" do
      expect(all_cards.uniq { |card| card.to_s }.count).to eq(all_cards.count)
    end
  end
 
  let(:cards) do
    [ Card.generate_random_card,
      Card.generate_random_card,
      Card.generate_random_card ]
  end

  describe "#initialize" do
    it "by default fills itself with 81 cards" do
      deck = Deck.new
      expect(deck.count).to eq(81)
    end

    it "can be initialized with an array of cards" do
      deck = Deck.new(cards)
      expect(deck.count).to eq(3)
    end
  end

  let(:deck) do
    Deck.new(cards.dup)
  end

  it "should not expose its cards" do
    expect(deck).not_to respond_to(:cards)
  end

  describe "#take" do
    # **use the front of the cards array as the top**
    it "takes cards off the top of the deck" do
      expect(deck.take(1)).to eq(cards[0..0])
      expect(deck.take(2)).to eq(cards[1..2])
    end

    it "removes cards from deck on take" do
      deck.take(2)
      expect(deck.count).to eq(1)
    end

    it "doesn't allow you to take more cards than are in the deck" do
      expect do
        deck.take(4)
      end.to raise_error("Not enough cards left in the deck to draw.")
    end
  end

  describe '#shuffle' do
    it 'should shuffle the cards' do
      cards = deck.take(3)
      deck.return(cards)

      not_shuffled = (1..5).all? do
        deck.shuffle
        shuffled_cards = deck.take(3)
        deck.return(shuffled_cards)

        (0..2).all? { |i| shuffled_cards[i] == cards[i] }
      end

      expect(not_shuffled).to be(false)
    end
  end
end
