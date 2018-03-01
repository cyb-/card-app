class Api::V1::Players::GamesController < Api::V1::Players::BaseController
  before_action :set_player

  def index
    @games = @player.games

    render "api/v1/games/index"
  end

end
