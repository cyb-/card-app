require 'rails_helper'
Dir[Rails.root.join('spec/api/v1/requests/shared/**/*.rb')].each { |f| require f }

RSpec.describe Api::V1::Games::FightsController, type: :request do
  let!(:player1)  { create(:player, :with_cards) }
  let!(:player2)  { create(:player, :with_cards) }
  let!(:game)     { create(:game, :with_fights, fights_count: 5, players: [player1, player2]) }

  let(:fight) { create(:fight, game: game) }

  describe "url helpers" do
    it { expect(api_v1_game_fights_path(1)).to eq("/api/v1/games/1/fights") }
  end

  describe "GET /api/v1/games/:game_id/fights" do
    before do
      create_list(:fight, 10)
      get api_v1_game_fights_path(game)
    end

    it_behaves_like "a success response"

    it { expect(mash).to have_attributes(fights: be_an(Array)) }

    it { expect(mash.fights.size).to eq(5) }

    it "returns a list of fight attributes" do
      expect(mash.fights.first).to have_attributes(
        id: be_a(Hash),
        created_at: be_a(String),
        updated_at: be_a(String),
        winner_id: a_value,
        hands: be_an(Array)
      )
    end

    it "return hand attributes" do
      expect(mash.fights.first.hands.first).to have_attributes(
        id: be_a(Hash),
        player_id: be_a(Hash),
        card_id: be_a(Hash)
      )
    end
  end

  describe "POST /api/v1/games/:game_id/fights" do
    let(:valid_attributes)    { { hands_attributes: [attributes_for(:hand, player_id: player1.id.to_s, card_id: player1.cards.sample.id.to_s), attributes_for(:hand, player_id: player2.id.to_s, card_id: player2.cards.sample.id.to_s)] } }
    let(:invalid_attributes)  { { hands_attributes: [attributes_for(:hand, player_id: player1.id.to_s, card_id: player1.cards.sample.id.to_s)] } }

    context "with valid params" do
      before do
        post api_v1_game_fights_path(game), params: { fight: valid_attributes }
      end

      it_behaves_like "a created response"

      it { expect(mash).to have_attributes(fight: a_value) }

      it "returns a new created fight attributes" do
        expect(mash.fight).to have_attributes(
          id: be_a(Hash),
          created_at: be_a(String),
          updated_at: be_a(String),
          winner_id: a_value,
          hands: be_an(Array)
        )
      end

      it "returns hand attributes" do
        expect(mash.fight.hands.first).to have_attributes(
          id: be_a(Hash),
          player_id: be_a(Hash),
          card_id: be_a(Hash)
        )
      end
    end

    context "with invalid params" do
      before do
        post api_v1_game_fights_path(game), params: { fight: invalid_attributes }
      end

      it_behaves_like "an unprocessable entity response"
    end
  end
end
