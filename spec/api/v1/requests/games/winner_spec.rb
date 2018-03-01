require 'rails_helper'
Dir[Rails.root.join('spec/api/v1/requests/shared/**/*.rb')].each { |f| require f }

RSpec.describe Api::V1::Games::WinnerController, type: :request do
  let!(:player1)  { create(:player, :with_cards) }
  let!(:player2)  { create(:player, :with_cards) }
  
  let(:game)          { create(:game, :with_fights, fights_count: 5, players: [player1, player2]) }
  let(:finished_game) { create(:game, :with_fights, fights_count: 10, players: [player1, player2]) }

  describe "url helpers" do
    it { expect(api_v1_game_winner_path(1)).to eq("/api/v1/games/1/winner") }
  end

  describe "GET /api/v1/games/:game_id/winner" do
    context "with a finished game" do
      context "with an equality game" do
        before do
          get api_v1_game_winner_path(finished_game)
        end

        it_behaves_like "a success response"

        it "returns the winner and looser attributes" do
          expect(mash).to have_attributes(
            winner: be_nil,
            looser: be_nil
          )
        end
      end
    end

    context "with an unfinished game" do
      before do
        get api_v1_game_winner_path(game)
      end

      it { expect(response).to have_http_status(:no_content) }
    end
  end

end
