class Api::V1::Games::BaseController < Api::V1::BaseController

  protected

  def set_game
    @game = Game.find(params[:game_id])
  end

end
