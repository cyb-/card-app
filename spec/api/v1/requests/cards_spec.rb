require 'rails_helper'
Dir[Rails.root.join('spec/api/v1/requests/shared/**/*.rb')].each { |f| require f }

RSpec.describe Api::V1::CardsController, type: :request do
  let(:card) { create(:card) }

  describe "url helpers" do
    it { expect(api_v1_cards_path).to eq("/api/v1/cards") }
    it { expect(api_v1_card_path(1)).to eq("/api/v1/cards/1") }
  end

  describe "GET /api/v1/cards" do
    before do
      create_list(:card, 5)
      get api_v1_cards_path
    end

    it_behaves_like "a success response"

    it { expect(mash).to have_attributes(cards: be_an(Array)) }

    it { expect(mash.cards.size).to eq(5) }

    it "returns a list of cards attributes" do
      expect(mash.cards.first).to have_attributes(
        id: be_a(Hash),
        name: be_a(String),
        health: be_an(Integer),
        strength: be_an(Integer),
        shield: be_an(Integer)
      )
    end
  end

  describe "GET /api/v1/cards/:card_id" do
    before do
      get api_v1_card_path(card)
    end

    it_behaves_like "a success response"

    it { expect(mash).to have_attributes(card: a_value) }

    it "returns the card attributes" do
      expect(mash.card).to have_attributes(
        id: card.id.as_json,
        name: card.name,
        health: card.health,
        strength: card.strength,
        shield: card.shield
      )
    end
  end
end
