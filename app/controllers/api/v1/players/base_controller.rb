class Api::V1::Players::BaseController < Api::V1::BaseController

  protected

  def set_player
    @player = Player.find(params[:player_id])
  end

end
