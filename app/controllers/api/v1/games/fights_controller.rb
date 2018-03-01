class Api::V1::Games::FightsController < Api::V1::Games::BaseController
  before_action :set_game

  def index
    @fights = @game.fights

    render "api/v1/fights/index"
  end

  def create
    @fight = @game.fights.build(fight_params)

    @fight.save!

    respond_to do |format|
      format.json { render "api/v1/fights/create", status: :created }
      format.any  { head :created }
    end
  end

  private

  def fight_params
    params.require(:fight).permit(hands_attributes: [:player_id, :card_id])
  end

end
