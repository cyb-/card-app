require 'rails_helper'
Dir[Rails.root.join('spec/api/v1/requests/shared/**/*.rb')].each { |f| require f }

RSpec.describe Api::V1::PlayersController, type: :request do
  let(:player) { create(:player) }

  describe "url helpers" do
    it { expect(api_v1_players_path).to eq("/api/v1/players") }
    it { expect(api_v1_player_path(1)).to eq("/api/v1/players/1") }
  end

  describe "GET /api/v1/players" do
    before do
      create_list(:player, 5)
      get api_v1_players_path
    end

    it_behaves_like "a success response"

    it { expect(mash).to have_attributes(players: be_an(Array)) }

    it { expect(mash.players.size).to eq(5) }

    it "returns a list of players attributes" do
      expect(mash.players.first).to have_attributes(
        id: be_a(Hash),
        name: be_a(String),
        created_at: be_a(String),
        updated_at: be_a(String)
      )
    end
  end

  describe "GET /api/v1/players/:player_id" do
    before do
      get api_v1_player_path(player)
    end

    it_behaves_like "a success response"

    it { expect(mash).to have_attributes(player: a_value) }

    it "returns the player attributes" do
      expect(mash.player).to have_attributes(
        id: player.id.as_json,
        name: player.name,
        created_at: player.created_at.as_json,
        updated_at: player.updated_at.as_json
      )
    end
  end
end
