class Api::V1::PlayersController < Api::V1::BaseController
  before_action :set_player, only: [:show]

  def index
    @players = Player.all
  end

  def show
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

end
