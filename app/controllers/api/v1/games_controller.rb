class Api::V1::GamesController < Api::V1::BaseController
  before_action :set_game, only: [:show]

  def index
    @games = Game.all
  end

  def create
    @game = Game.new(game_params)

    @game.save!

    respond_to do |format|
      format.json { render :show, status: :created }
      format.any  { head :created }
    end
  end

  def show
  end

  private

  def set_game
    @game = Game.includes(:players).find(params[:id])
  end

  def game_params
    params.require(:game).permit(player_ids: [])
  end

end
