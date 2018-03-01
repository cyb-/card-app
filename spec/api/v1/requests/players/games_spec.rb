require 'rails_helper'
Dir[Rails.root.join('spec/api/v1/requests/shared/**/*.rb')].each { |f| require f }

RSpec.describe Api::V1::Players::GamesController, type: :request do
  let!(:player) { create(:player, :with_games, games_count: 5) }

  describe "url helpers" do
    it { expect(api_v1_player_games_path(1)).to eq("/api/v1/players/1/games") }
  end

  describe "GET /api/v1/players/:player_id/games" do
    before do
      create_list(:game, 10)
      get api_v1_player_games_path(player)
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

end
