require 'rails_helper'
Dir[Rails.root.join('spec/api/v1/requests/shared/**/*.rb')].each { |f| require f }

RSpec.describe Api::V1::GamesController, type: :request do
  let(:game) { create(:game) }

  describe "url helpers" do
    it { expect(api_v1_games_path).to eq("/api/v1/games") }
    it { expect(api_v1_game_path(1)).to eq("/api/v1/games/1") }
  end

  describe "GET /api/v1/games" do
    before do
      create_list(:game, 5)
      get api_v1_games_path
    end

    it_behaves_like "a success response"

    it { expect(mash).to have_attributes(games: be_an(Array)) }

    it { expect(mash.games.size).to eq(5) }

    it "returns a list of game attributes" do
      expect(mash.games.first).to have_attributes(
        id: be_a(Hash),
        created_at: be_a(String),
        updated_at: be_a(String),
        player_ids: be_an(Array)
      )
    end
  end

  describe "POST /api/v1/games" do
    let!(:player1) { create(:player) }
    let!(:player2) { create(:player) }

    let(:valid_attributes)    { { player_ids: [player1.id.to_s, player2.id.to_s] } }
    let(:invalid_attributes)  { { player_ids: [player1.id.to_s] } }

    context "with valid params" do
      before do
        post api_v1_games_path, params: { game: valid_attributes }
      end

      it_behaves_like "a created response"

      it { expect(mash).to have_attributes(game: a_value) }

      it "returns a new created game attributes" do
        expect(mash.game).to have_attributes(
          id: be_a(Hash),
          created_at: be_a(String),
          updated_at: be_a(String),
          player_ids: be_an(Array),
          players: be_an(Array)
        )
      end
    end

    context "with invalid params" do
      before do
        post api_v1_games_path, params: { game: invalid_attributes }
      end

      it_behaves_like "an unprocessable entity response"
    end
  end

  describe "GET /api/v1/games/:game_id" do
    before do
      get api_v1_game_path(game)
    end

    it_behaves_like "a success response"

    it { expect(mash).to have_attributes(game: a_value) }

    it "returns the game attributes" do
      expect(mash.game).to have_attributes(
        id: game.id.as_json,
        created_at: game.created_at.as_json,
        updated_at: game.updated_at.as_json,
        player_ids: game.player_ids.map(&:as_json),
        players: be_an(Array)
      )
    end
  end

end
