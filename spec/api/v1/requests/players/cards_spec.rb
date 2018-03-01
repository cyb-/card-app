require 'rails_helper'
Dir[Rails.root.join('spec/api/v1/requests/shared/**/*.rb')].each { |f| require f }

RSpec.describe Api::V1::Players::CardsController, type: :request do
  let!(:player) { create(:player, :with_cards, cards_count: 5) }

  describe "url helpers" do
    it { expect(api_v1_player_cards_path(1)).to eq("/api/v1/players/1/cards") }
  end

  describe "GET /api/v1/players/:player_id/cards" do
    before do
      create_list(:card, 10)
      get api_v1_player_cards_path(player)
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

end
